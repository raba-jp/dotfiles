# chezmoi → mise bootstrap 移行 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** dotfiles 管理を chezmoi から mise bootstrap へ移行し、copy 方式による「ローカル編集 → source へ手動同期」の往復を symlink 方式で解消する。

**Architecture:** リポジトリを `home/` 配下に `$HOME` の構造をそのまま写す配置へ再構成する。chezmoi の `dot_` / `private_` / `executable_` プレフィックスは廃止し、実行ビットは git のファイルモードで表現する。マニフェストはリポジトリ root の `mise.toml` 一枚に集約し、これを `~/.config/mise/config.toml` から symlink して mise のグローバル設定そのものとして機能させる（mise の self-managing config パターン）。`Brewfile` と `run_*` スクリプトは `[bootstrap.packages]` と `[tasks.bootstrap]` に吸収して削除する。

**Tech Stack:** mise 2026.8.6+（`mise bootstrap` / `[dotfiles]`）、fish + fisher、Homebrew（cask のみ mise が肩代わり）

**前提となる調査結果:** すべて mise 2026.8.6 で実機検証済み。

- `symlink-each` は管理外ファイルと共存し、source 削除時にリンクを prune する
- `source` 省略時は `dotfiles.root` 配下へ home 相対パスで写像される（`~/.config` → `<root>/.config`）
- `dotfiles.root` と `[dotfiles]` の値は `~` 展開される。ただし**パス自体はテンプレート展開されない**
- apply は 1 エントリでもエラーだと全体が中断する
- formula は Homebrew と完全に相互運用できるが、**cask は brew 所有のものを mise が引き継げない**（要 uninstall → 再インストール）
- サードパーティ tap（sketchybar / omniwm / qmk）は mise では扱えないため管理対象外とする（対応済み）

---

## File Structure

### 移行後のリポジトリ構成

```
.
├── mise.toml                              # マニフェスト兼 mise グローバル設定
├── README.md
├── LICENSE
├── .editorconfig
├── .gitignore
├── .github/
├── docs/superpowers/plans/                # 本計画
├── scripts/colortest.sh                   # リポジトリ内に置くだけ。配布しない
└── home/                                  # $HOME に対応（dotfiles.root）
    ├── .claude/settings.json
    ├── .config/
    │   ├── bat/config
    │   ├── fish/config.fish
    │   ├── fish/fish_plugins              # 新規
    │   ├── gh/config.yml
    │   ├── gh/hosts.yml
    │   ├── ghostty/config
    │   ├── git/config
    │   ├── git/ignore
    │   ├── omniwm/settings.toml
    │   ├── sketchybar/sketchybarrc        (0755)
    │   ├── sketchybar/plugins/*.sh        (0755, 5 ファイル)
    │   ├── wezterm/wezterm.lua
    │   ├── zed/keymap.json
    │   └── zed/settings.json
    └── (以上)
```

`scripts/colortest.sh` は `$HOME` へ配らない。リポジトリ内に置いたまま必要なときに直接実行する。chezmoi では `~/scripts/colortest.sh` として配布されていたが、これは意図した配置ではなかったため移行を機に取りやめる。

`home/.config/mise/` は作らない。`~/.config/mise/config.toml` は root の `mise.toml` への symlink として `[dotfiles]` の明示エントリで張る。

### 削除するファイル

| ファイル | 吸収先 |
| --- | --- |
| `.chezmoiignore` | 不要（mise は宣言したものだけ配る） |
| `Brewfile` | `[bootstrap.packages]` |
| `scripts/run_onchange_install_packages.sh.tmpl` | `[bootstrap.packages]` |
| `scripts/run_once_after_install_fish_plugins.fish` | `home/.config/fish/fish_plugins` + `[tasks.bootstrap]` |
| `dot_config/mise/settings.toml` | `mise.toml` の `[settings]` |

### 各ファイルの責務

- **`mise.toml`** — 唯一のマニフェスト。dotfiles 配置・OS パッケージ・開発ツール・bootstrap タスクをすべてここで宣言する。`~/.config/mise/config.toml` へ symlink されるため、リポジトリ外からも `mise bootstrap` が効く。
- **`home/`** — `$HOME` のミラー。ここに置いたファイルは `~/.config` の `symlink-each` により自動でリンクされる（`.config` 配下の場合）。新しい設定ファイルを足すときはここに置くだけでよく、`mise.toml` の編集は不要。
- **`home/.config/fish/fish_plugins`** — fisher が読むプラグイン一覧。`fisher update` が冪等に収束させる。

---

## Task 1: 現状のベースラインを固定する

移行後の出力が現状と一致することを検証するための基準を取る。ここで取った基準が以降すべてのタスクの合否判定になる。

**Files:**
- Create: `/tmp/mig/baseline.txt`（一時ファイル、コミットしない）

**注意:** このタスクは `git push` や `~/.local/share/chezmoi` への書き込みを行わない。実機の変更は Task 8 に集約する。

- [ ] **Step 1: ローカルのドリフトを確認する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
chezmoi status --source .
```

Expected: 何も出力されなければドリフト無し。`MM .claude/settings.json` のような行が出た場合は実機側が新しいので Step 2 で取り込む。

- [ ] **Step 2: ドリフトの向きを判定する**

**「実機が常に正」ではない。** 必ず両方の中身を見て、どちらが意図した状態か判断すること。`chezmoi add` は既定の source（`~/.local/share/chezmoi`）を書き換えてしまうため使わない。

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
chezmoi diff --source . ~/.claude/settings.json     # - が実機、+ がリポジトリの desired state
git log --oneline -5 -- dot_claude/settings.json    # リポジトリ側の変更経緯
```

**2026-08-15 時点の判定結果:** `.claude/settings.json` の `enabledPlugins` はリポジトリが 5 件、実機が 1 件。リポジトリ側は 2026-07-07 のコミット `f9d26eb`「Sync local settings to chezmoi source」で意図的に入れられたものなので、**リポジトリを正とする**。実機側は Task 8 の `--force` で上書きされる。したがってこの Step でリポジトリを変更する必要はない。

`chezmoi status --source .` には `R scripts/install_packages.sh` が残るが、これはドリフトではない。`run_onchange_install_packages.sh.tmpl` が `{{ .chezmoi.sourceDir }}` を埋め込んでいるため、`--source .` で source パスを差し替えると必ず差分が出る。`--exclude=scripts` で除外するので Step 4 のベースラインには影響しない。

- [ ] **Step 2b: 実機を正とすべきドリフトがあった場合のみ取り込む**

```bash
cp ~/.claude/settings.json dot_claude/settings.json   # 実機が正と判断した場合のみ
git add -A && git commit -m "chore: sync local drift before mise migration"
```

Expected: 判定の結果リポジトリが正なら、このリポジトリへのコミットは発生しない。

- [ ] **Step 3: 巻き戻し用のタグをローカルに打つ**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
git tag pre-mise-migration
git tag -l pre-mise-migration
```

Expected: `pre-mise-migration` が表示される。push は Task 8 で行う。

- [ ] **Step 4: chezmoi の適用結果をベースラインとして採取する**

```bash
rm -rf /tmp/mig && mkdir -p /tmp/mig/chezmoi-home
chezmoi apply --source "$PWD" --destination /tmp/mig/chezmoi-home --exclude=scripts --force
find /tmp/mig/chezmoi-home -mindepth 1 | sort | while read -r p; do
  rel="${p#/tmp/mig/chezmoi-home/}"
  if [ -d "$p" ] && [ ! -L "$p" ]; then echo "d $rel"
  else printf 'f %s %s\n' "$rel" "$(shasum -a256 "$p" | cut -c1-12)"; fi
done > /tmp/mig/baseline.txt
wc -l /tmp/mig/baseline.txt
```

Expected: `35 /tmp/mig/baseline.txt`（ディレクトリ 14 + ファイル 21）。`--exclude=scripts` は `run_*` スクリプトの実行（`brew bundle` が走る）を防ぐために必須。`--destination` で隔離しているので実 `$HOME` は変更されない。

---

## Task 2: ディレクトリを新レイアウトへ再構成する

**Files:**
- Move: `dot_config/` → `home/.config/`
- Move: `dot_claude/` → `home/.claude/`
- Delete: `dot_config/mise/`, `scripts/run_once_after_install_fish_plugins.fish`, `scripts/run_onchange_install_packages.sh.tmpl`
- Keep: `scripts/colortest.sh`（移動しない）

- [ ] **Step 1: ディレクトリを移動する**

`scripts/` は配布対象から外すのでリポジトリ root に残す。

```bash
mkdir -p home
git mv dot_config home/.config
git mv dot_claude home/.claude
```

- [ ] **Step 2: chezmoi のプレフィックスを外す**

```bash
git mv home/.config/private_omniwm home/.config/omniwm
git mv home/.config/zed/private_settings.json home/.config/zed/settings.json
git mv home/.config/sketchybar/executable_sketchybarrc home/.config/sketchybar/sketchybarrc
for f in home/.config/sketchybar/plugins/executable_*.sh; do
  git mv "$f" "${f/executable_/}"
done
```

Expected: `home/.config/sketchybar/plugins/` に `battery.sh` `clock.sh` `front_app.sh` `space.sh` `volume.sh` が並ぶ。

- [ ] **Step 3: 実行ビットを git のファイルモードで表現する**

chezmoi の `executable_` プレフィックスは適用時に chmod していた。mise は symlink なので source 側のモードがそのまま効く。git は実行ビットを記録するのでこれで移植できる。

```bash
chmod +x home/.config/sketchybar/sketchybarrc home/.config/sketchybar/plugins/*.sh
git update-index --chmod=+x home/.config/sketchybar/sketchybarrc
for f in home/.config/sketchybar/plugins/*.sh; do git update-index --chmod=+x "$f"; done
git ls-files -s home/.config/sketchybar
```

Expected: 6 ファイルすべて `100755`。

- [ ] **Step 4: 不要になった mise 設定と chezmoi スクリプトを削除する**

`settings.toml` の `experimental = true` は Task 3 で `mise.toml` の `[settings]` に集約する。

```bash
git rm -r home/.config/mise
git rm scripts/run_once_after_install_fish_plugins.fish
git rm scripts/run_onchange_install_packages.sh.tmpl
```

Expected: `scripts/` に `colortest.sh` だけが残る。

- [ ] **Step 5: 配置を確認する**

```bash
find home -type f | sort
ls scripts
```

Expected: `home` 配下は 18 ファイル（`home/.claude/settings.json` 1 個 + `home/.config` 配下 17 個）。`home/.config/mise` は存在しない。`scripts` には `colortest.sh` のみ。

- [ ] **Step 6: コミットする**

```bash
git add -A
git commit -m "refactor: restructure dotfiles into home/ layout for mise"
```

---

## Task 3: mise.toml を作成する

**Files:**
- Create: `mise.toml`

- [ ] **Step 1: マニフェストを書く**

`mise.toml` を以下の内容で作成する。

```toml
# mise グローバル設定 兼 dotfiles マニフェスト
# ~/.config/mise/config.toml へ symlink して使う

[settings]
experimental = true
dotfiles.root = "~/ghq/github.com/raba-jp/dotfiles/home"
dotfiles.default_mode = "symlink"

[dotfiles]
# source 省略時は dotfiles.root 配下へ home 相対で写像される
# ~/.config      -> ~/ghq/github.com/raba-jp/dotfiles/home/.config
"~/.config" = { mode = "symlink-each" }
"~/.claude" = { mode = "symlink-each" }
# マニフェスト自身。home/ の外にあるので source を明示する
"~/.config/mise/config.toml" = "~/ghq/github.com/raba-jp/dotfiles/mise.toml"

[bootstrap.packages]
"brew:atuin" = "latest"
"brew:bat" = "latest"
"brew:crit" = "latest"
"brew:eza" = "latest"
"brew:fish" = "latest"
"brew:fzf" = "latest"
"brew:gh" = "latest"
"brew:ghq" = "latest"
"brew:mise" = "latest"
"brew:starship" = "latest"

"brew-cask:appcleaner" = { os = "macos" }
"brew-cask:comet" = { os = "macos" }
"brew-cask:conductor" = { os = "macos" }
"brew-cask:discord" = { os = "macos" }
"brew-cask:ghostty" = { os = "macos" }
"brew-cask:granola" = { os = "macos" }
"brew-cask:heptabase" = { os = "macos" }
"brew-cask:lm-studio" = { os = "macos" }
"brew-cask:obsidian" = { os = "macos" }
"brew-cask:proton-pass" = { os = "macos" }
"brew-cask:qlmarkdown" = { os = "macos" }
"brew-cask:thaw" = { os = "macos" }
"brew-cask:the-unarchiver" = { os = "macos" }
"brew-cask:zed" = { os = "macos" }
"brew-cask:zoom" = { os = "macos" }

"brew-cask:font-moralerspace" = { os = "macos" }
"brew-cask:font-moralerspace-hw" = { os = "macos" }
"brew-cask:font-moralerspace-hw-jpdoc" = { os = "macos" }
"brew-cask:font-moralerspace-jpdoc" = { os = "macos" }
"brew-cask:font-udev-gothic" = { os = "macos" }
"brew-cask:font-udev-gothic-nf" = { os = "macos" }

[tools]
fnox = "latest"
node = "lts"
"npm:@anthropic-ai/claude-code" = "latest"
"npm:@biomejs/biome" = "latest"
"ubi:wagoodman/dive" = "latest"

[tasks.bootstrap]
shell = "fish -c"
run = '''
functions -q fisher; or begin
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
    fisher install jorgebucaran/fisher
end
fisher update
'''
```

`chezmoi` は `[bootstrap.packages]` に入れない。カットオーバー完了時に `brew uninstall chezmoi` する。
`sketchybar` / `omniwm` / `qmk` はサードパーティ tap のため管理対象外（手動インストール）。

- [ ] **Step 2: パースと解決結果を確認する**

```bash
mise trust
mise bootstrap dotfiles status
```

Expected: 3 行。source 列がそれぞれ以下に解決されていること。

```
~/.config                   symlink-each  ~/ghq/github.com/raba-jp/dotfiles/home/.config
~/.claude/settings.json     symlink       ~/ghq/github.com/raba-jp/dotfiles/home/.claude/settings.json
~/.config/mise/config.toml  symlink       ~/ghq/github.com/raba-jp/dotfiles/mise.toml
```

state 列は clone 先がまだ無いので `source missing`、または実機に chezmoi の実ファイルがあるため `differs` になる。どちらでも正常。**`status` は読み取り専用なので実 `$HOME` は変更されない。**

- [ ] **Step 3: パッケージが全件解決できることを確認する**

```bash
mise bootstrap packages status
```

Expected: formula 10 行がすべて `installed`。cask 21 行はすべて表示される（`missing` 表示は Homebrew 所有のためで正常、Task 8 で解消する）。エラーが 1 行でも出たら止まる。

- [ ] **Step 4: コミットする**

```bash
git add mise.toml
git commit -m "feat: add mise.toml as the dotfiles manifest"
```

---

## Task 4: 隔離環境で chezmoi と等価であることを検証する

実 `$HOME` を触らずに、mise の適用結果が Task 1 のベースラインと一致することを確かめる。

**Files:**
- Create: `/tmp/mig/sandbox/mise.toml`（一時ファイル、コミットしない）

- [ ] **Step 1: 隔離先へ適用するためのサンドボックス設定を書く**

`~` は実 `$HOME` に展開されてしまうため、検証では絶対パスの明示 source を使う。

```bash
mkdir -p /tmp/mig/sandbox
cat > /tmp/mig/sandbox/mise.toml <<EOF
[settings]
dotfiles.default_mode = "symlink"

[dotfiles]
"/tmp/mig/home/.config" = { source = "$PWD/home/.config", mode = "symlink-each" }
"/tmp/mig/home/.claude/settings.json" = "$PWD/home/.claude/settings.json"
"/tmp/mig/home/.config/mise/config.toml" = "$PWD/mise.toml"
EOF
```

- [ ] **Step 2: 適用する**

```bash
cd /tmp/mig/sandbox && mise trust && mise bootstrap dotfiles apply --yes
```

Expected:

```
mise files: created 17 symlink(s) from .../home/.config in /tmp/mig/home/.config
mise files: created symlink /tmp/mig/home/.claude/settings.json -> ...
mise files: created symlink /tmp/mig/home/.config/mise/config.toml -> .../mise.toml
```

- [ ] **Step 3: ベースラインと比較する**

```bash
find /tmp/mig/home -mindepth 1 | sort | while read -r p; do
  rel="${p#/tmp/mig/home/}"
  if [ -d "$p" ] && [ ! -L "$p" ]; then echo "d $rel"
  else printf 'f %s %s\n' "$rel" "$(shasum -a256 "$p" | cut -c1-12)"; fi
done > /tmp/mig/after.txt
diff /tmp/mig/baseline.txt /tmp/mig/after.txt
```

Expected: `baseline.txt` は 35 行、`after.txt` は 32 行。差分は以下の 2 か所だけで、これ以外が出たら再構成にミスがある。

```
17,18c17
< f .config/mise/config.toml <hash-A>
< f .config/mise/settings.toml <hash-B>
---
> f .config/mise/config.toml <hash-C>
34,35d32
< d scripts
< f scripts/colortest.sh <hash-D>
```

意図した差分の内訳:
- `config.toml` — 中身がマニフェストに変わったため
- `settings.toml` — `[settings] experimental = true` へ集約して削除したため
- `scripts/` — `colortest.sh` を `$HOME` へ配らなくしたため

- [ ] **Step 4: パーミッションを確認する**

```bash
for f in .config/sketchybar/sketchybarrc .config/sketchybar/plugins/battery.sh \
         .config/zed/settings.json .config/omniwm; do
  printf '%-42s chezmoi=%s  mise=%s\n' "$f" \
    "$(stat -Lf '%Sp' /tmp/mig/chezmoi-home/$f)" "$(stat -Lf '%Sp' /tmp/mig/home/$f)"
done
```

Expected:

```
.config/sketchybar/sketchybarrc        chezmoi=-rwxr-xr-x  mise=-rwxr-xr-x   ← 一致
.config/sketchybar/plugins/battery.sh  chezmoi=-rwxr-xr-x  mise=-rwxr-xr-x   ← 一致
.config/zed/settings.json              chezmoi=-rw-------  mise=-rw-r--r--   ← 意図的
.config/omniwm                         chezmoi=drwx------  mise=drwxr-xr-x   ← 意図的
```

600/700 は不要と判断済み。実行ビットが git 経由で正しく移植できていることがここで確認できる。

- [ ] **Step 5: 後片付け**

```bash
rm -rf /tmp/mig/sandbox /tmp/mig/home
```

---

## Task 5: fish プラグイン管理を移行する

`run_once_after_install_fish_plugins.fish` は一度しか走らないため、プラグインを足しても既存マシンに反映されなかった。`fish_plugins` + `fisher update` にすると毎回収束する。

**Files:**
- Create: `home/.config/fish/fish_plugins`

- [ ] **Step 1: プラグイン一覧を作る**

削除した `run_once_after_install_fish_plugins.fish` と同じ 4 つを列挙する。ただし **fisher が書き出す正規形（小文字）に合わせる**こと。旧スクリプトは `PatrickF1/fzf.fish` と書いていたが、fisher は `fish_plugins` へ書き戻すときにリポジトリ名を小文字化するため、実機は `patrickf1/fzf.fish` になっている。カットオーバー後は `~/.config/fish/fish_plugins` がリポジトリへの symlink になるので、大文字のままにすると `fisher update` のたびにリポジトリが dirty になる。

`home/.config/fish/fish_plugins`:

```
jorgebucaran/fisher
patrickf1/fzf.fish
rose-pine/fish
decors/fish-ghq
```

- [ ] **Step 2: 実機の現状と一致しているか確認する**

```bash
fish -c 'fisher list'
```

Expected: 上記 4 つが並ぶ。差があれば `fish_plugins` を実機側に合わせる（実機が正）。

- [ ] **Step 3: bootstrap タスクが fish で走ることを確認する**

```bash
mise run bootstrap
```

Expected: `fisher update` が走り、`Fetching`/`Installing` もしくは変更なしで正常終了する。`shell = "fish -c"` が効いていないと `functions: command not found` になる。

- [ ] **Step 4: コミットする**

```bash
git add home/.config/fish/fish_plugins
git commit -m "feat: manage fish plugins declaratively with fish_plugins"
```

---

## Task 6: chezmoi 資産を撤去する

**Files:**
- Delete: `.chezmoiignore`, `Brewfile`

- [ ] **Step 1: 削除する**

`Brewfile` の内容は Task 3 で `[bootstrap.packages]` に転記済み。`.chezmoiignore` は mise では不要（宣言したものだけが配られるため）。

```bash
git rm .chezmoiignore Brewfile
```

- [ ] **Step 2: 取りこぼしが無いか確認する**

```bash
git ls-files | grep -E 'chezmoi|Brewfile|dot_|run_on|run_once' || echo "残存なし"
```

Expected: `残存なし`

- [ ] **Step 3: コミットする**

```bash
git commit -m "chore: remove chezmoi artifacts"
```

---

## Task 7: README を更新する

**Files:**
- Modify: `README.md`

- [ ] **Step 1: 新しいセットアップ手順を書く**

`README.md` を以下の内容で置き換える。

````markdown
# dotfiles

My macOS configurations, managed with [mise](https://mise.jdx.dev/bootstrap.html).

## Setup

```sh
brew install mise
ghq get https://github.com/raba-jp/dotfiles.git
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap --yes
```

## Layout

- `mise.toml` — マニフェスト。`~/.config/mise/config.toml` へ symlink される
- `home/` — `$HOME` のミラー。`home/.config/**` は `~/.config/**` へ symlink される

新しい設定ファイルを追加するときは `home/` の対応する位置に置いて `mise bootstrap dotfiles apply` するだけでよい。`~/.config` 配下なら `mise.toml` の編集は不要。

## Commands

```sh
mise bootstrap status              # 全体の drift を確認
mise bootstrap dotfiles status     # dotfiles だけ確認
mise bootstrap dotfiles apply      # 反映
mise bootstrap --yes               # パッケージ・ツール含めて丸ごと収束
```

## Not managed

サードパーティ tap を必要とするため、以下は手動インストール。

- [sketchybar](https://github.com/FelixKratz/SketchyBar) (`FelixKratz/formulae`)
- [OmniWM](https://github.com/BarutSRB/OmniWM) (`BarutSRB/tap`)
- [qmk](https://github.com/qmk/homebrew-qmk) (`qmk/qmk`)

設定ファイルは `home/.config/sketchybar/` と `home/.config/omniwm/` で管理している。
````

- [ ] **Step 2: コミットする**

```bash
git add README.md
git commit -m "docs: update setup instructions for mise bootstrap"
```

---

## Task 8: 実機カットオーバー

**ここから実 `$HOME` を変更する。Task 1〜7 をマージしてから実施すること。**

- [ ] **Step 1: マージして clone し直す**

```bash
git push origin pre-mise-migration
git push
gh pr create --base main --title "Migrate dotfiles from chezmoi to mise bootstrap" --fill
# レビュー・マージ後
ghq get https://github.com/raba-jp/dotfiles.git
ls ~/ghq/github.com/raba-jp/dotfiles/mise.toml
```

Expected: `mise.toml` が存在する。

- [ ] **Step 2: ドリフトが無いことを再確認する**

```bash
cd ~/.local/share/chezmoi && git pull --ff-only && chezmoi status
```

Expected: 空。ここで差分が出たら Task 1 Step 2 と同じ手順で取り込んでからやり直す。**差分を残したまま次へ進むとローカルの変更が上書きされる。**

- [ ] **Step 3: 差分を確認してから適用する**

chezmoi が置いた実ファイルを symlink に置き換える。リポジトリと実機の内容は Step 2 で一致を確認済みなので `--force` は安全。

```bash
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap dotfiles apply --dry-run --verbose
```

Expected: `~/.config` 配下 17 個、`~/.claude` 配下 1 個の symlink 作成と、`~/.config/mise/config.toml` の個別 symlink が列挙される。想定外のパスが出ていないか目視する。

最終的な chezmoi との差分は以下の 5 点のみであることを Task 4 で確認済み。

| 差分 | 理由 |
| --- | --- |
| `+ .config/fish/fish_plugins` | Task 5 で追加 |
| `- .config/gh/hosts.yml` | 認証情報の書き込み先なので管理対象から除外（public リポジトリ） |
| `.config/mise/config.toml` の内容変更 | マニフェストになったため |
| `- .config/mise/settings.toml` | `[settings]` へ集約 |
| `- scripts/colortest.sh` | `$HOME` へ配らなくしたため |

```bash
mise bootstrap dotfiles apply --yes --force
```

Expected: `mise files: applied ...`。エラーが出たら中断して原因を潰す（apply は全体が中断するので中途半端な状態にはならない）。

- [ ] **Step 4: 反映を確認する**

```bash
mise bootstrap dotfiles status
ls -la ~/.config/mise/config.toml ~/.config/fish/config.fish ~/.claude/settings.json
```

Expected: 3 エントリすべて `applied`。3 ファイルとも `~/ghq/github.com/raba-jp/dotfiles/` 配下への symlink になっている。

- [ ] **Step 5: シェルを開き直して動作確認する**

```bash
exec fish
mise --version
sketchybar --version
```

Expected: fish が正常に起動し、abbr / alias / starship / atuin が効く。`~/.config/mise/config.toml` が symlink に変わっているので mise が新しいマニフェストを読んでいることも確認できる。

- [ ] **Step 6: chezmoi を撤去する**

```bash
rm -rf ~/.local/share/chezmoi ~/.cache/chezmoi ~/.config/chezmoi
brew uninstall chezmoi
```

Expected: `chezmoi` コマンドが消える。`~/.config/chezmoi` は存在しない場合もある。

- [ ] **Step 7: cask を mise 管理へ移す（任意・段階実施可）**

mise は Homebrew 所有の cask を引き継げないため、移したいものだけ入れ直す。アプリのユーザーデータは `~/Library` 配下に残るので消えない（`zap` は `--zap` 指定時のみ動く）。入れ直しコストの低いフォントから始めるとよい。

```bash
brew uninstall --cask font-udev-gothic font-udev-gothic-nf font-moralerspace \
  font-moralerspace-hw font-moralerspace-hw-jpdoc font-moralerspace-jpdoc
mise bootstrap packages apply --yes
mise bootstrap packages status
```

Expected: 対象の cask が `installed` に変わる。残りのアプリは都合のよいときに同じ手順で移す。

既知の劣化: `ghostty` を mise 経由で入れると `manpage` artifact が黙って無視されるため `man ghostty` が引けなくなる。アプリ本体と shell completion は正常に入る。

- [ ] **Step 8: 全体の収束を確認する**

```bash
mise bootstrap status
```

Expected: dotfiles・tools・packages が一覧される。まだ移していない cask が `missing` として残るのは想定どおり。

---

## Rollback

Task 8 の Step 3 以降で問題が起きた場合。

```bash
cd ~/ghq/github.com/raba-jp/dotfiles
mise bootstrap dotfiles unapply --dry-run   # 消える対象を確認
mise bootstrap dotfiles unapply
brew install chezmoi
chezmoi init https://github.com/raba-jp/dotfiles.git --branch pre-mise-migration
chezmoi apply
```

`pre-mise-migration` は Task 1 Step 3 で打ったタグ。

`unapply` は symlink が設定どおりの source を指している間だけ削除するので、手で編集したものは残る。

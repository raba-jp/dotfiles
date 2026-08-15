# worktree からの copy 配布への移行 実装計画

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** `[dotfiles]` を symlink から copy へ切り替え、任意の checkout から配布できるようにして、配布専用の常設 clone を不要にする。

**Architecture:** mise の設定を役割で 2 つに割る。`home/.config/mise/config.toml` は「どこからでも有効である必要があるもの」（`[tools]` と `[settings] experimental`）だけを持ち、普通の dotfile として copy 配布される。リポジトリ root の `mise.toml` はマシンセットアップ（`[dotfiles]` `[bootstrap.packages]` `[tasks.bootstrap]`）を持ち、project config としてリポジトリ内から実行する。`[dotfiles]` の source をすべて相対パスにすることで、実行した checkout が配布元になる。

**Tech Stack:** mise 2026.8.6+（`[dotfiles]` の `copy` モード、設定階層マージ）

**設計根拠:** `docs/superpowers/specs/2026-08-15-worktree-copy-distribution-design.md` を参照。以下は実測済みの前提。

- 相対 source は**設定ファイル自身の場所**を基準に解決される（symlink の実体側は見ない）
- `[settings]` は設定階層でマージされ、**project config の `dotfiles.default_mode` がグローバル設定のエントリの挙動を書き換える**
- `mise bootstrap dotfiles add` はディレクトリ `copy` エントリ配下のファイルを未管理と判定し、新規エントリを作ってファイルを移動する（使わない）
- `copy` に prune は無い

---

## 現在の状態

作業ブランチ `raba-jp/mise-bootstrap-vs-chezmoi`、コミット `0c4952b`。

**重要な前提: このワークスペースの `mise.toml` は実機のグローバル設定ではない。**

```
~/.config/mise/config.toml  --symlink-->  ~/ghq/github.com/raba-jp/dotfiles/mise.toml
```

実機のグローバル設定は **ghq clone の** `mise.toml` である。Conductor ワークスペース
（`/Users/sakuraba/conductor/workspaces/dotfiles/biarritz`）の `mise.toml` は別ファイルなので、
Task 2〜5 でこれを編集しても実機には影響しない。実機が変わるのは Task 6 だけ。

現行 `mise.toml`（68 行）は 1 ファイルに全部入っている。

```toml
[settings]
experimental = true
dotfiles.root = "~/ghq/github.com/raba-jp/dotfiles/home"
dotfiles.default_mode = "symlink"

[dotfiles]
"~/.config" = { mode = "symlink-each" }
"~/.claude" = { mode = "symlink-each" }
"~/.config/mise/config.toml" = "~/ghq/github.com/raba-jp/dotfiles/mise.toml"

[bootstrap.packages]   # brew 10 + brew-cask 21
[tools]                # fnox, node, npm×2, ubi×1
[tasks.bootstrap]      # fisher
```

---

## File Structure

### 作成

| ファイル | 責務 |
| --- | --- |
| `home/.config/mise/config.toml` | mise グローバル設定。`[settings] experimental` と `[tools]` のみ。**`[dotfiles]` を書いてはならない** — 書くとリポジトリへ `cd` しただけで配布挙動が変わる |

### 変更

| ファイル | 変更内容 |
| --- | --- |
| `mise.toml` | マシンセットアップ専用にする。`[tools]` と `[settings] experimental` を削除、`dotfiles.root` を削除、`dotfiles.default_mode` を `copy` に、`[dotfiles]` を相対 source の 2 エントリに置換 |
| `README.md` | 配布・書き戻し・新規マシンの手順を新方式に更新 |

### 変更しない

`home/` 配下の既存 18 ファイル、`scripts/colortest.sh`、`docs/`。

---

## Task 1: 移行前スナップショットを採取する

カットオーバー後の検証基準を作る。**コミットは発生しない。**

**Files:**
- Create: `/tmp/copymig/before.txt`（一時ファイル）

- [ ] **Step 1: 実機が健全であることを確認する**

```bash
cd ~/ghq/github.com/raba-jp/dotfiles
git status --short
mise bootstrap dotfiles status
```

Expected: `git status` は空。`status` は 3 エントリすべて `applied`。

```
~/.config                   symlink-each  ~/ghq/github.com/raba-jp/dotfiles/home/.config  applied
~/.claude                   symlink-each  ~/ghq/github.com/raba-jp/dotfiles/home/.claude  applied
~/.config/mise/config.toml  symlink       ~/ghq/github.com/raba-jp/dotfiles/mise.toml     applied
```

`applied` でないものがあれば STOP して報告する。以降の検証基準が狂う。

- [ ] **Step 2: 配布済みファイルの内容とモードを記録する**

`stat -L` と `shasum` は symlink を辿るので、記録されるのは解決先の実体である。

```bash
rm -rf /tmp/copymig && mkdir -p /tmp/copymig
{
  for f in $(find ~/ghq/github.com/raba-jp/dotfiles/home -type f | sort); do
    rel="${f#$HOME/ghq/github.com/raba-jp/dotfiles/home/}"
    printf '%s %s %s\n' "$rel" "$(shasum -a256 "$HOME/$rel" | cut -c1-16)" "$(stat -Lf '%Sp' "$HOME/$rel")"
  done
} > /tmp/copymig/before.txt
wc -l /tmp/copymig/before.txt
cat /tmp/copymig/before.txt
```

Expected: 18 行。`.config/sketchybar/` の 6 行が `-rwxr-xr-x`、残りが `-rw-r--r--`。

- [ ] **Step 3: グローバル設定の現在値を記録する**

Task 6 で `~/.config/mise/config.toml` は symlink から実体コピーへ変わる。何が失われるかを明示しておく。

```bash
shasum -a256 ~/.config/mise/config.toml | cut -c1-16 > /tmp/copymig/global-before.txt
cat /tmp/copymig/global-before.txt
```

Expected: 16 桁のハッシュが 1 行。

---

## Task 2: グローバル設定を切り出す

**Files:**
- Create: `home/.config/mise/config.toml`

- [ ] **Step 1: ファイルを作成する**

現行 `mise.toml` の `[settings] experimental` と `[tools]` をそのまま移す。**`[dotfiles]` は絶対に書かない。**

`home/.config/mise/config.toml`:

```toml
# mise グローバル設定
# dotfiles マニフェストはリポジトリ root の mise.toml にある。
# [dotfiles] をここに書いてはならない。[settings] は設定階層でマージされるため、
# 両方に存在するとリポジトリへ cd しただけで配布挙動が変わる。

[settings]
experimental = true

[tools]
fnox = "latest"
node = "lts"
"npm:@anthropic-ai/claude-code" = "latest"
"npm:@biomejs/biome" = "latest"
"ubi:wagoodman/dive" = "latest"
```

- [ ] **Step 2: `[tools]` が現行と一致することを確認する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
diff <(sed -n '/^\[tools\]/,/^$/p' mise.toml) <(sed -n '/^\[tools\]/,$p' home/.config/mise/config.toml)
```

Expected: 差分なし（末尾の空行の有無のみ許容）。差分が出たら転記ミスなので直す。

- [ ] **Step 3: TOML として妥当か確認する**

```bash
python3 -c "import tomllib;d=tomllib.load(open('home/.config/mise/config.toml','rb'));print(sorted(d.keys()));print(sorted(d['tools'].keys()))"
```

Expected:

```
['settings', 'tools']
['fnox', 'node', 'npm:@anthropic-ai/claude-code', 'npm:@biomejs/biome', 'ubi:wagoodman/dive']
```

`dotfiles` がキーに含まれていたら設計違反なので直す。

- [ ] **Step 4: コミットする**

```bash
git add home/.config/mise/config.toml
git commit -m "feat: split mise global config into a deployed dotfile"
```

---

## Task 3: mise.toml をマニフェスト専用に書き換える

**Files:**
- Modify: `mise.toml`

- [ ] **Step 1: 全体を置き換える**

`mise.toml` を以下の内容にする。`[bootstrap.packages]` と `[tasks.bootstrap]` は現行から変更しない。

```toml
# dotfiles マニフェスト兼マシンセットアップ設定
#
# これは project config である。リポジトリ内で実行すること。
# source は相対パスなので、実行した checkout が配布元になる。
# 任意の worktree から `mise bootstrap dotfiles apply` できる。
#
# mise のグローバル設定（[tools] など）は home/.config/mise/config.toml にあり、
# 普通の dotfile として配布される。

[settings]
dotfiles.default_mode = "copy"

[dotfiles]
"~/.config" = { source = "home/.config", mode = "copy" }
"~/.claude" = { source = "home/.claude", mode = "copy" }

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

削除される 3 つを意識すること。

- `[settings] experimental` → `home/.config/mise/config.toml` へ移動済み
- `[settings] dotfiles.root` → **削除**。全 source が相対で明示されるため不要であり、残すと設定階層でグローバル側を上書きする
- `[tools]` → `home/.config/mise/config.toml` へ移動済み

- [ ] **Step 2: パッケージ一覧が変わっていないことを確認する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
diff <(git show HEAD:mise.toml | grep -E '^"brew' | sort) <(grep -E '^"brew' mise.toml | sort)
```

Expected: 差分なし（31 エントリが不変）。

- [ ] **Step 3: 構造を確認する**

```bash
python3 -c "
import tomllib
d = tomllib.load(open('mise.toml','rb'))
print('keys:', sorted(d.keys()))
print('settings:', d['settings'])
print('dotfiles:', d['dotfiles'])
print('packages:', len(d['bootstrap']['packages']))
print('has tools:', 'tools' in d)
"
```

Expected:

```
keys: ['bootstrap', 'dotfiles', 'settings', 'tasks']
settings: {'dotfiles': {'default_mode': 'copy'}}
dotfiles: {'~/.config': {'source': 'home/.config', 'mode': 'copy'}, '~/.claude': {'source': 'home/.claude', 'mode': 'copy'}}
packages: 31
has tools: False
```

`settings` に `dotfiles.root` や `experimental` が残っていたら削除漏れ。

- [ ] **Step 4: コミットする**

```bash
git add mise.toml
git commit -m "feat: make mise.toml a relocatable dotfiles manifest"
```

---

## Task 4: 隔離環境で配布結果を検証する

実 `$HOME` を変えずに、新マニフェストが Task 1 のスナップショットと同じ内容を配布することを確かめる。**コミットは発生しない。**

**Files:**
- Create: `/tmp/copymig/sandbox/mise.toml`（一時ファイル）

- [ ] **Step 1: 事故を避けるための事前確認**

`mise bootstrap dotfiles apply` は project config だけでなく**グローバル設定のエントリも処理する**。実機のグローバル設定（ghq clone の `mise.toml`）はまだ symlink 方式のままなので、サンドボックス実行時にその 3 エントリも評価される。すでに `applied` なら no-op で済む。

```bash
cd ~/ghq/github.com/raba-jp/dotfiles && mise bootstrap dotfiles status
```

Expected: 3 エントリすべて `applied`。1 つでも `differs` なら STOP。no-op にならず実機が変わる。

- [ ] **Step 2: サンドボックス設定を書く**

**`[settings]` ブロックを書いてはならない。** `dotfiles.default_mode` を書くとグローバル設定側の
`~/.config/mise/config.toml` エントリ（モード無指定の文字列形式）に適用され、実機の symlink が
実体コピーへ変換される。検証中に実際に起きた事故なので、各エントリに `mode` を明示して回避する。

```bash
mkdir -p /tmp/copymig/sandbox
cat > /tmp/copymig/sandbox/mise.toml <<EOF
[dotfiles]
"/tmp/copymig/home/.config" = { source = "$PWD/home/.config", mode = "copy" }
"/tmp/copymig/home/.claude" = { source = "$PWD/home/.claude", mode = "copy" }
EOF
cat /tmp/copymig/sandbox/mise.toml
```

Expected: source が Conductor ワークスペースの絶対パスに展開されている。`$PWD` がリポジトリ root
でないと source がずれるので、実行前に `pwd` が
`/Users/sakuraba/conductor/workspaces/dotfiles/biarritz` であることを確認する。

- [ ] **Step 3: サンドボックスへ配布する**

```bash
cd /tmp/copymig/sandbox && mise trust && mise bootstrap dotfiles apply --yes
```

Expected: 2 行のコピーが報告される。実機側のエントリについて `created` や `copied` が出たら
STOP して報告する（Step 1 の前提が崩れている）。

```
mise files: copied .../home/.config to /tmp/copymig/home/.config
mise files: copied .../home/.claude to /tmp/copymig/home/.claude
```

- [ ] **Step 4: スナップショットと突き合わせる**

```bash
{
  for f in $(find /Users/sakuraba/conductor/workspaces/dotfiles/biarritz/home -type f | sort); do
    rel="${f#/Users/sakuraba/conductor/workspaces/dotfiles/biarritz/home/}"
    printf '%s %s %s\n' "$rel" "$(shasum -a256 "/tmp/copymig/home/$rel" | cut -c1-16)" "$(stat -f '%Sp' "/tmp/copymig/home/$rel")"
  done
} > /tmp/copymig/after.txt
diff /tmp/copymig/before.txt /tmp/copymig/after.txt
```

Expected: 差分は 1 行だけ。`.config/mise/config.toml` が Task 2 で新規追加されたため、`before.txt`
に無く `after.txt` にある。

```
> .config/mise/config.toml <hash> -rw-r--r--
```

これ以外の差分が出たら STOP。内容かモードが変わっている。

- [ ] **Step 5: 実行ビットを個別に確認する**

```bash
stat -f '%Sp %N' /tmp/copymig/home/.config/sketchybar/sketchybarrc /tmp/copymig/home/.config/sketchybar/plugins/*.sh | sed 's|/tmp/copymig/home/||'
```

Expected: 6 行すべて `-rwxr-xr-x`。

- [ ] **Step 6: 別ディレクトリからの配布でも同じ結果になることを確認する**

「任意の checkout から配布できる」という要件そのものの検証。ワークスペースを複製し、片方の
内容を変えて配布し、変更が反映されることを見る。

```bash
cp -R /Users/sakuraba/conductor/workspaces/dotfiles/biarritz /tmp/copymig/wt2
rm -rf /tmp/copymig/wt2/.git
printf '# from wt2\n' >> /tmp/copymig/wt2/home/.config/bat/config
cat > /tmp/copymig/sandbox/mise.toml <<'EOF'
[dotfiles]
"/tmp/copymig/home/.config" = { source = "/tmp/copymig/wt2/home/.config", mode = "copy" }
EOF
cd /tmp/copymig/sandbox && mise trust && mise bootstrap dotfiles apply --yes
tail -1 /tmp/copymig/home/.config/bat/config
```

Expected: `# from wt2` が出力される。別 checkout の内容で上書きされたことの証明。

- [ ] **Step 7: 後片付けと実機の健全性確認**

```bash
rm -rf /tmp/copymig/sandbox /tmp/copymig/home /tmp/copymig/wt2
cd ~/ghq/github.com/raba-jp/dotfiles && mise bootstrap dotfiles status
git -C ~/ghq/github.com/raba-jp/dotfiles status --short
```

Expected: 3 エントリすべて `applied`、ghq clone は clean。`/tmp/copymig/before.txt` は Task 6 で
使うので消さない。

---

## Task 5: README を更新する

**Files:**
- Modify: `README.md`

- [ ] **Step 1: 全体を置き換える**

`README.md` を以下の内容にする。

````markdown
# dotfiles

My macOS configurations, managed with [mise](https://mise.jdx.dev/bootstrap.html).

## Setup

[Homebrew](https://brew.sh/) が入っている前提。clone 先はどこでもよい。

```sh
brew install mise ghq
ghq get https://github.com/raba-jp/dotfiles.git
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap --yes
mise install
```

`mise install` が別途必要なのは、`[tools]` を持つグローバル設定が dotfiles 配布フェーズで初めて
出現するため。mise は起動時に設定を読むので、同一実行内では反映されない。

## Layout

- `mise.toml` — dotfiles マニフェスト兼マシンセットアップ設定。**project config なのでリポジトリ内で実行する**
- `home/` — `$HOME` のミラー。`home/.config/**` が `~/.config/**` へコピーされる
- `home/.config/mise/config.toml` — mise のグローバル設定（`[tools]` など）。普通の dotfile として配布される

`[dotfiles]` の source は相対パスなので、**実行した checkout が配布元になる**。worktree からでも
そのまま配れるし、配布後にその worktree を消しても `$HOME` は壊れない。

## Commands

配布は任意の checkout から。

```sh
mise bootstrap dotfiles status     # drift を確認
mise bootstrap dotfiles apply      # 配布
mise bootstrap --yes               # パッケージ・ツール含めて丸ごと収束
```

`[dotfiles]` と `[bootstrap.packages]` はグローバル設定に置いていないため、これらはリポジトリ内で
実行する必要がある。

### 設定ファイルを追加する

`home/` の対応する位置に置いて apply するだけでよい。ディレクトリ単位のエントリが覆うので
`mise.toml` の編集は不要。

### 実機の変更を取り込む

Zed / Claude Code / OmniWM は自分で設定ファイルを書き換える。その変更は手でリポジトリへ戻す。

```sh
mise bootstrap dotfiles status
# → differs (zed/settings.json differs) のように対象が出る
cp ~/.config/zed/settings.json home/.config/zed/settings.json
```

`mise bootstrap dotfiles add` は使わないこと。ディレクトリエントリ配下のファイルを未管理と判定し、
新しいエントリを作った上でファイルを移動してしまう。

## Caveats

- `copy` に prune は無い。リポジトリからファイルを消しても `$HOME` 側は残るので手で削除する
- Homebrew でインストール済みの cask は mise が引き継げず `missing` と表示される。移すには
  `brew uninstall --cask <name>` してから `mise bootstrap packages apply`
- `ghostty` を mise 経由で入れると cask の `manpage` artifact が無視され `man ghostty` が引けなくなる
- 認証情報を書き込むファイルは `home/` に置かないこと。このリポジトリは public

## Not managed

サードパーティ tap を必要とするため、以下は手動インストール。

- [sketchybar](https://github.com/FelixKratz/SketchyBar) (`FelixKratz/formulae`)
- [OmniWM](https://github.com/BarutSRB/OmniWM) (`BarutSRB/tap`)
- [qmk](https://github.com/qmk/homebrew-qmk) (`qmk/qmk`)

設定ファイルは `home/.config/sketchybar/` と `home/.config/omniwm/` で管理している。
````

Note: 上の外側フェンスは ```` ```` ```` （バッククォート 4 つ）で、内側の ``` を表示するための
ものである。実際の `README.md` は `# dotfiles` で始まり `home/.config/omniwm/` の行で終わる。
4 連バッククォート自体をファイルに含めないこと。

- [ ] **Step 2: コード塀が壊れていないか確認する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
grep -c '^```' README.md
head -1 README.md; tail -1 README.md
```

Expected: バッククォート 3 連の行数が偶数（塀が閉じている）。先頭が `# dotfiles`、末尾が
`設定ファイルは ...` の行。

- [ ] **Step 3: コミットする**

```bash
git add README.md
git commit -m "docs: describe copy-based distribution from any checkout"
```

---

## Task 6: 実機カットオーバー

**ここから実 `$HOME` を変更する。Task 1〜5 を終えてから実施すること。**

配布は **Conductor ワークスペースから直接行う**。ghq clone は pull せずそのまま削除する。
これは手抜きではなく、過渡状態を作らないための積極的な選択である。

**なぜ ghq clone を pull してはならないか。** `~/.config/mise/config.toml` は ghq clone の
`mise.toml` への symlink である。clone を pull した瞬間、実機のグローバル設定が新マニフェスト
（相対 source、`dotfiles.default_mode = "copy"`）に化ける。その状態で apply すると、グローバル側と
プロジェクト側が同一キー `~/.config` `~/.claude` を持ち、しかもグローバル側の相対 source は
`~/.config/mise/home/.config` という存在しないパスへ解決される。マージ結果が読めないので、この
状態を作らない。

代わりに、古い symlink を先に外してからワークスペースで apply する。グローバル設定が一時的に
不在になるが、apply が `home/.config/mise/config.toml` をコピーして即座に復旧させる。

- [ ] **Step 1: push して PR を更新する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
git push
gh pr view --json url,state
```

Expected: 既存 PR #194 が更新される。

- [ ] **Step 2: 古いグローバル設定の symlink を外す**

```bash
ls -l ~/.config/mise/config.toml
rm ~/.config/mise/config.toml
ls ~/.config/mise/
```

Expected: 削除前は ghq clone への symlink。削除後、`~/.config/mise/` は空か、無関係なファイルのみ。

この時点でグローバル mise 設定が無くなるため、`[tools]` と `experimental` が一時的に効かなくなる。
Step 4 で復旧する。

- [ ] **Step 3: dry-run で内容を確認する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
mise trust
mise bootstrap dotfiles status
mise bootstrap dotfiles apply --dry-run --verbose
```

Expected: エントリは 2 つだけ（グローバル設定が無くなったので、旧マニフェストの 3 エントリは
出てこない）。source はこのワークスペースの絶対パスに解決されている。既存ターゲットが symlink
なので `--force` が要る旨が示される。

3 エントリ出てきた場合は Step 2 の削除が効いていないので STOP。

- [ ] **Step 4: 適用する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
mise bootstrap dotfiles apply --yes --force
```

Expected:

```
mise files: copied .../biarritz/home/.config to ~/.config
mise files: copied .../biarritz/home/.claude to ~/.claude
mise files: applied ~/.config, ~/.claude
```

- [ ] **Step 5: 検証する**

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
mise bootstrap dotfiles status

# 全ターゲットが実ファイルであること（symlink が残っていないこと）
n=0; bad=0
for f in $(find home -type f | sort); do
  rel="${f#home/}"
  if [ -L "$HOME/$rel" ]; then printf '★ symlink 残存: %s\n' "$rel"; bad=$((bad+1)); else n=$((n+1)); fi
done
printf '実ファイル=%s  symlink=%s\n' "$n" "$bad"

# 内容がスナップショットと一致すること
{
  for f in $(find home -type f | sort); do
    rel="${f#home/}"
    printf '%s %s %s\n' "$rel" "$(shasum -a256 "$HOME/$rel" | cut -c1-16)" "$(stat -Lf '%Sp' "$HOME/$rel")"
  done
} > /tmp/copymig/final.txt
diff /tmp/copymig/before.txt /tmp/copymig/final.txt
```

Expected: `status` は 2 エントリとも `applied`。`実ファイル=19  symlink=0`。diff は
`.config/mise/config.toml` の 1 行追加のみ。それ以外が出たら STOP。

- [ ] **Step 6: ツールとシェルが動くことを確認する**

```bash
cat ~/.config/mise/config.toml
mise ls --current
cd /tmp && mise ls --current
fish -l -c 'echo ok; type -q starship; and echo starship; functions -q fisher; and echo fisher'
```

Expected: `~/.config/mise/config.toml` は実ファイルで、`[settings]` と `[tools]` のみを含む
（`[dotfiles]` が無いこと）。`[tools]` の 5 つが解決される。リポジトリ外（`/tmp`）でも解決される。
fish がエラーなく起動する。

- [ ] **Step 7: ghq clone を削除する**

配布物は実ファイルなので、配布元を消しても `$HOME` は壊れない。これが今回の移行の眼目である。

```bash
rm -rf ~/ghq/github.com/raba-jp/dotfiles
ls ~/.config/fish/config.fish ~/.config/mise/config.toml
fish -l -c 'echo still ok'
mise ls --current | head -3
mise bootstrap dotfiles status 2>&1 | head -3
```

Expected: ファイルは残り、fish も mise も正常に動く。`/tmp` など無関係な場所からの
`mise bootstrap dotfiles status` は「nothing configured in [dotfiles]」を返す（グローバル設定に
`[dotfiles]` を置かない設計どおり）。

- [ ] **Step 8: 後片付け**

```bash
rm -rf /tmp/copymig
ls -d ~/.dotfiles-pre-mise-backup 2>/dev/null && rm -rf ~/.dotfiles-pre-mise-backup
```

`~/.dotfiles-pre-mise-backup` は chezmoi 移行時のバックアップ。ここまで検証が通っていれば不要。

---

## Rollback

Task 6 の Step 4 以降で問題が起きた場合。配布物は実ファイルなので、リポジトリを戻して apply し
直すだけでよい。

```bash
cd /Users/sakuraba/conductor/workspaces/dotfiles/biarritz
git revert --no-edit $(git log --format=%H --grep='make mise.toml a relocatable dotfiles manifest' -1) \
                     $(git log --format=%H --grep='split mise global config into a deployed dotfile' -1)
mise bootstrap dotfiles apply --yes --force
```

これで `mise.toml` が symlink 方式に戻り、`home/.config/mise/config.toml` が削除される。ただし
`~/.config/mise/config.toml` は copy された実ファイルのまま残るので、symlink へ戻すために
`--force` が要る。また Task 6 Step 7 で ghq clone を削除済みの場合、旧マニフェストの
`dotfiles.root = "~/ghq/github.com/raba-jp/dotfiles/home"` が存在しないパスを指すため、clone を
作り直す必要がある。

```bash
ghq get https://github.com/raba-jp/dotfiles.git
```

chezmoi 時代まで戻す場合は `pre-mise-migration` タグを使う。ただし chezmoi の再インストールが
必要で、`.chezmoiignore` を削除済みのため `chezmoi apply` はタグの状態から実行すること。

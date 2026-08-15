# worktree からの dotfiles 配布 設計

## 目的

任意の git worktree / checkout から dotfiles を配布できるようにし、配布専用の常設 clone を不要にする。

## 背景

2026-08-15 に chezmoi から mise bootstrap へ移行した際、`[dotfiles]` を symlink モードで構成した。symlink は配布元の実体が消えると壊れるため、`dotfiles.root` を固定パス `~/ghq/github.com/raba-jp/dotfiles/home` に固定する必要があった。

結果、同一リポジトリの checkout が 3 つ並存している。

```
~/conductor/repos/dotfiles              [main]     Conductor の親 clone
~/conductor/workspaces/dotfiles/<name>  [branch]   Conductor の worktree（作業場所）
~/ghq/github.com/raba-jp/dotfiles       [branch]   配布実体（symlink 先）
```

作業は worktree で行うのに配布元が別 clone なので、変更を実機へ届けるには「worktree で編集 → push → ghq clone で pull」の 3 ホップを要する。移行作業中の `config.fish` の修正で実際にこの摩擦を踏んだ。

配布物を実ファイルのコピーにすれば、配布元が消えても `$HOME` は壊れない。配布元が ephemeral な worktree でよくなり、常設 clone が不要になる。

## 設計判断とその根拠

すべて mise 2026.8.6 の実測にもとづく。

### 相対 source は「設定ファイル自身の場所」を基準に解決される

symlink された設定ファイルでは、実体側ではなく symlink の置き場所が基準になる。

```
/tmp/wt/proj/mise.toml -> /tmp/wt/repo/manifest.toml
source = "home/.config"  →  /private/tmp/wt/proj/home/.config
```

したがって `~/.config/mise/config.toml` を symlink にしたまま相対パスを使うことはできない。逆に、worktree 内の `mise.toml` を **project config として直接実行**すれば、相対 source はその worktree を基準に解決される。これが本設計の土台である。

### `[settings]` は設定階層でマージされ、グローバル側の挙動を書き換える

リポジトリの `mise.toml` に `dotfiles.default_mode = "copy"` を書くと、グローバル設定に属するエントリの既定モードまで変わる。検証中に実際に `~/.config/mise/config.toml` が symlink から実体コピーへ変換される事故が起きた。

**帰結: グローバル設定に `[dotfiles]` を置いてはならない。** 両方に存在すると、リポジトリへ `cd` するだけで配布挙動が変わる。

### `mise bootstrap dotfiles add` はディレクトリ copy 配下のファイルを認識しない

ヘルプの "If the target is already managed, this updates its source" の *managed* は、**エントリのキーとターゲットパスが完全一致する場合のみ**を指す。ディレクトリエントリに覆われているだけのファイルは未管理と判定され、新規エントリを作成した上でファイルを移動してしまう。

```
$ mise bootstrap dotfiles add ~/probe/.config/zed/settings.json
mise dotfiles: moved ... to <repo>/home/probe/.config/zed/settings.json
mise dotfiles: added ... to ~/.config/mise/config.toml
```

一方 `status` は差分を正しく検出する。

```
~/.config  copy  <repo>/home/.config  differs (zed/settings.json differs)
```

**帰結: 書き戻しは `status` で対象を特定し `cp` で行う。**

## 構成

### 設定ファイルの分割

役割で 2 つに分ける。境界の原則は「どこからでも有効である必要があるものだけをグローバルに置く」。

| ファイル | 内容 | 種別 |
| --- | --- | --- |
| `home/.config/mise/config.toml` | `[settings] experimental`、`[tools]` | グローバル設定。普通の dotfile として copy 配布される |
| `<repo>/mise.toml` | `[settings] dotfiles.default_mode`、`[dotfiles]`、`[bootstrap.packages]`、`[tasks.bootstrap]` | project config。リポジトリ内で実行する |

`[tools]`（fnox / node / claude-code / biome / dive）はどのディレクトリでも解決される必要があるためグローバル。マシンセットアップに属するもの（dotfiles 配布、OS パッケージ、fisher）はリポジトリ側に置き、リポジトリ内から実行する。

この分割は副次的に、コードレビューで指摘された `mise run bootstrap` の名前衝突も解消する。`[tasks.bootstrap]` がグローバルにあると、無関係なプロジェクトで `mise run bootstrap` と打っただけで `fisher update` が走ってしまう。リポジトリ側に置けばリポジトリ内でしか起動しない。

### マニフェスト

```toml
# <repo>/mise.toml
[settings]
dotfiles.default_mode = "copy"

[dotfiles]
"~/.config" = { source = "home/.config", mode = "copy" }
"~/.claude" = { source = "home/.claude", mode = "copy" }
```

`dotfiles.root` は**設定しない**。全エントリが相対 source を明示するので不要であり、設定すると階層マージでグローバル側を上書きする危険がある。

エントリはディレクトリ単位の 2 つに絞る。ファイル単位（19 エントリ）にすれば `add` による書き戻しが使えるようになるが、日常操作である「ファイル追加」のたびに `mise.toml` の編集を強いる。稀な操作である書き戻しのために頻繁な操作を重くする取引は割に合わない。

### リポジトリ構成

```
mise.toml                          dotfiles マニフェスト
home/
  .claude/settings.json
  .config/
    mise/config.toml               ← 新規。グローバル mise 設定
    bat/config
    fish/config.fish
    fish/fish_plugins
    gh/config.yml
    ghostty/config
    git/{config,ignore}
    omniwm/settings.toml
    sketchybar/sketchybarrc        (0755)
    sketchybar/plugins/*.sh        (0755, 5 ファイル)
    wezterm/wezterm.lua
    zed/{keymap.json,settings.json}
scripts/colortest.sh               配布しない
```

`home/` は 19 ファイルになる（現在の 18 + `.config/mise/config.toml`）。

## ワークフロー

### 配布

任意の checkout で実行する。実行した checkout の内容が配布される。

```sh
cd <任意の checkout>
mise bootstrap dotfiles apply
```

### 変更の追加（主フロー）

`home/` の対応する位置にファイルを置き、apply する。ディレクトリエントリが覆うので `mise.toml` の編集は不要。

### 書き戻し（副フロー）

Zed / Claude Code / OmniWM は自分で設定ファイルを書き換えるため、これらの変更はリポジトリへ手で戻す。

```sh
mise bootstrap dotfiles status          # differs のファイル名が出る
cp ~/.config/zed/settings.json home/.config/zed/settings.json
```

`mise bootstrap dotfiles add` は使わない（前述の理由により、新規エントリを作ってファイルを移動してしまう）。

### 新規マシン

```sh
brew install mise ghq
ghq get https://github.com/raba-jp/dotfiles.git
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap --yes    # パッケージ導入、dotfiles 配布、fisher セットアップ
mise install            # 配布されたグローバル設定の [tools] を導入
```

2 段になるのは、`[tools]` を保持するグローバル設定が dotfiles 配布フェーズで初めて出現するため。mise は起動時に設定を読み込むので、同一実行内では反映されない。

なお clone 先は任意でよい。`dotfiles.root` に依存しないため、パスの制約は無い。

## カットオーバー

現在の 18 個の symlink を実ファイルへ置き換える。

1. `home/.config/mise/config.toml` を作成し、現行 `mise.toml` から `[settings] experimental` と `[tools]` を移す
2. `<repo>/mise.toml` を新マニフェストへ書き換える
3. 任意の checkout から `mise bootstrap dotfiles apply --yes --force` を実行
   - `--force` が要るのは、既存ターゲットが symlink であり copy エントリと型が食い違うため
   - `~/.config/mise/config.toml` は symlink から `home/.config/mise/config.toml` の実体コピーへ変わる
4. 検証（下記）
5. `~/ghq/github.com/raba-jp/dotfiles` を削除する

順序が重要である。手順 5 を先に実行すると、symlink が全滅した状態になる。

## 検証

カットオーバー前に、現在の symlink 解決先の内容をスナップショットとして採取する。カットオーバー後に以下を満たすこと。

- `$HOME` 側の全 19 ファイルが、リポジトリの `home/` 配下と byte 単位で一致する
- 全ターゲットが**実ファイルである**（symlink が 1 つも残っていない）
- `home/.config/sketchybar/` の 6 ファイルが `-rwxr-xr-x` である
- `mise bootstrap dotfiles status` が 2 エントリとも `applied` を返す
- ghq clone を削除した後も上記が維持される
- `mise ls` がリポジトリ外から `[tools]` を解決できる
- fish が起動し、alias / abbr / starship / atuin / fisher が機能する

## 既知の制約

移行にあたって受け入れる代償を明示する。

**symlink による自動書き戻しを失う。** これは chezmoi → mise 移行の当初動機そのものであり、`Sync local settings to chezmoi source` 系のコミットが復活する可能性がある。worktree 配布を優先する判断としてこれを受け入れる。ただし `status` が差分を検出するため、chezmoi 時代と違い「気づかないまま乖離する」ことは避けられる。

**`copy` に prune が無い。** リポジトリからファイルを削除しても `$HOME` の配布済みファイルは残り続ける。不要になったファイルは手で削除する。

**リポジトリ外で `mise bootstrap dotfiles status` は何も返さない。** グローバル設定に `[dotfiles]` を置かない設計の必然的な帰結。drift 確認はリポジトリ内で行う。

**`mise bootstrap packages status` も同様にリポジトリ内でのみ機能する。**

## 却下した代替案

**配布用 worktree を固定パスに作る（symlink 維持）。** `~/ghq/github.com/raba-jp/dotfiles` を Conductor 親リポジトリの worktree にすれば、object store が共有され clone が 1 つ減り、GitHub 経由の push / pull 往復も不要になる。symlink の自動書き戻しも保てる。ただし配布元は依然として固定パスの常設 checkout であり、「任意の worktree から配布する」という要件は満たさない。要件を優先して却下した。

**ファイル単位のエントリ（19 個）。** `add` による書き戻しが使えるようになるが、ファイル追加のたびに `mise.toml` の編集を要する。前述のとおり取引が割に合わない。

**ディレクトリエントリと個別エントリの併用。** アプリが書き換える 3 ファイルだけ個別エントリにする案。同一パスの二重管理となり、mise はこれを検出しない。得られる利益に対しリスクが見合わない。

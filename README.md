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

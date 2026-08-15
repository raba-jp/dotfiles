# dotfiles

My macOS configurations, managed with [mise](https://mise.jdx.dev/bootstrap.html).

## Setup

[Homebrew](https://brew.sh/) が入っている前提。

```sh
brew install mise ghq
ghq get https://github.com/raba-jp/dotfiles.git
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap --yes
```

`mise.toml` の `dotfiles.root` はこの clone 先を絶対パスで指しているので、`~/ghq/github.com/raba-jp/dotfiles` 以外の場所には置けない。

## Layout

- `mise.toml` — マニフェスト。`~/.config/mise/config.toml` へ symlink される
- `home/` — `$HOME` のミラー。`home/.config/**` は `~/.config/**` へ symlink される

新しい設定ファイルを追加するときは `home/` の対応する位置に置いて `mise bootstrap dotfiles apply` するだけでよい。`~/.config` と `~/.claude` は `symlink-each` なので `mise.toml` の編集は不要。

symlink なので、アプリが自分の設定を書き換えるとこのリポジトリの作業ツリーが直接変更される。`~/.claude/settings.json` や `~/.config/zed/settings.json` は通常利用で dirty になる。**認証情報を書き込むファイルは管理対象に入れないこと**（`gh` の `hosts.yml` はこの理由で管理していない。このリポジトリは public）。

## Commands

```sh
mise bootstrap status              # 全体の drift を確認
mise bootstrap dotfiles status     # dotfiles だけ確認
mise bootstrap dotfiles apply      # 反映
mise bootstrap --yes               # パッケージ・ツール含めて丸ごと収束
```

`[dotfiles]` と `[bootstrap.packages]` はグローバル設定に置かれるため、**どのディレクトリで実行してもこの dotfiles と全パッケージが対象になる**。プロジェクト内で `mise bootstrap` / `mise run bootstrap` と打つと個人設定が `$HOME` へ適用される点に注意。

Homebrew でインストール済みの cask は mise が引き継げないため `missing` と表示される。mise 管理へ移すには一度アンインストールしてから入れ直す。

```sh
brew uninstall --cask <name>
mise bootstrap packages apply
```

`ghostty` は mise 経由で入れると cask の `manpage` artifact が無視されるため `man ghostty` が引けなくなる。

## Not managed

サードパーティ tap を必要とするため、以下は手動インストール。

- [sketchybar](https://github.com/FelixKratz/SketchyBar) (`FelixKratz/formulae`)
- [OmniWM](https://github.com/BarutSRB/OmniWM) (`BarutSRB/tap`)
- [qmk](https://github.com/qmk/homebrew-qmk) (`qmk/qmk`)

設定ファイルは `home/.config/sketchybar/` と `home/.config/omniwm/` で管理している。

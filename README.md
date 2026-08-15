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

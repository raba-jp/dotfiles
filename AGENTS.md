# Agent Instructions

macOS の個人 dotfiles リポジトリ。[mise](https://mise.jdx.dev/bootstrap.html) の `[dotfiles]` で管理している。

## 最重要: このリポジトリはユーザーの実 `$HOME` に配布される

`mise bootstrap dotfiles apply` は `~/.config/**` と `~/.claude/**` を**上書きする破壊的操作**である。
ユーザーが明示的に依頼したときだけ実行し、その前に必ず内容差を確認すること。

以下のコマンドは**依頼されない限り実行しないこと**。

| コマンド | 影響 |
| --- | --- |
| `mise bootstrap dotfiles apply` | `$HOME` の設定ファイルを上書きする |
| `mise bootstrap`（引数なし） | 上記に加え OS パッケージのインストールまで走る |
| `mise bootstrap packages apply` | Homebrew パッケージをインストールする |
| `mise run bootstrap` | `fisher update` が走り fish プラグインを再構成する |
| `mise bootstrap dotfiles add` | **使ってはならない**。後述 |

`mise bootstrap dotfiles status` は読み取り専用なので自由に使ってよい。

## 絶対に壊してはいけない不変条件

**グローバル設定 `home/.config/mise/config.toml` に `[dotfiles]` と `dotfiles.default_mode` を書いてはならない。**

mise の `[settings]` は設定階層をまたいでマージされる。そのため project config の
`dotfiles.default_mode` が、グローバル設定に属するエントリの適用モードまで書き換えてしまう。
この設計を検証している最中に、これが原因で実機の symlink が実体コピーへ変換される事故が
2 回発生している。

同じ理由で、**検証用のサンドボックス設定にも `[settings]` を書かないこと**。各エントリに
`mode` を明示して、既定値に依存しない形にする。

```toml
# 検証用サンドボックスの正しい書き方
[dotfiles]
"/tmp/sandbox/.config" = { source = "/abs/path/home/.config", mode = "copy" }
```

## 配布モデル

**copy モード。** 配布物は実ファイルなので、配布元の checkout を消しても `$HOME` は壊れない。
`[dotfiles]` の source は相対パスであり、**`mise` を実行した checkout が配布元になる**。
任意の git worktree から配布できる。

配布専用の常設 clone は存在しない。リポジトリの実体は Conductor の
`~/conductor/repos/dotfiles` とその worktree のみ。

### 設定ファイルの分割

| ファイル | 内容 | 種別 |
| --- | --- | --- |
| `mise.toml` | `[dotfiles]`、`[bootstrap.packages]`、`[tasks.bootstrap]` | project config。リポジトリ内で実行する |
| `home/.config/mise/config.toml` | `[settings] experimental`、`[tools]` | グローバル設定。dotfile として配布される |

「どこからでも有効である必要があるものだけをグローバルに置く」という原則で分けている。
その結果、リポジトリ外では `mise bootstrap dotfiles status` も `packages status` も空を返す。
これは不具合ではなく設計どおり。

## レイアウト

```
mise.toml                      マニフェスト
home/                          $HOME のミラー
  .claude/settings.json        → ~/.claude/settings.json
  .config/**                   → ~/.config/**
scripts/colortest.sh           配布しない。リポジトリ内で直接実行する
docs/superpowers/              設計ドキュメントと実装計画
```

`~/.config` と `~/.claude` はディレクトリ単位の 2 エントリで覆っている。
**設定ファイルを追加するときは `home/` の対応する位置に置くだけでよく、`mise.toml` の編集は不要。**

## 実機の変更をリポジトリへ戻す

Zed / Claude Code / OmniWM は自分で設定ファイルを書き換えるため、その変更は手で戻す。

```sh
mise bootstrap dotfiles status
# → differs (zed/settings.json differs) のように対象が出る
cp ~/.config/zed/settings.json home/.config/zed/settings.json
```

**`mise bootstrap dotfiles add` は使わないこと。** ヘルプの "If the target is already managed" の
*managed* はエントリのキーとターゲットパスが完全一致する場合のみを指す。ディレクトリエントリに
覆われているだけのファイルは未管理と判定され、新規エントリを作った上で**ファイルを移動**して
しまう。しかも書き込み先は既定でグローバル設定である。

## 制約

- **`copy` に prune が無い。** リポジトリからファイルを削除しても `$HOME` 側は残る。手で消す
- **実行ビットは git のファイルモードで表現する。** 新しいスクリプトを足したら
  `git update-index --chmod=+x <path>` を忘れないこと。`home/.config/sketchybar/` の 6 ファイルが該当
- **認証情報を書き込むファイルを `home/` に置かないこと。このリポジトリは public。**
  copy 配布でもツールが `$HOME` 側を書き換え、それを `cp` で戻す運用なので、トークンが
  tracked file に入る経路がある。`gh` の `hosts.yml` はこの理由で管理対象外にしている
- **サードパーティ tap を要するパッケージは管理対象外。** mise の Homebrew 実装は API メタデータ
  （`api/formula/*.json`）を publish している tap しか扱えない。sketchybar / OmniWM / qmk は
  手動インストール。設定ファイルだけリポジトリで管理している
- **chezmoi は撤去済み。** `chezmoi` コマンドを使わないこと。`.chezmoiignore` も削除済みなので、
  仮に再インストールして `chezmoi apply` するとリポジトリ全体が `$HOME` に撒かれる

## 新規マシンのセットアップ

```sh
brew install mise ghq
ghq get https://github.com/raba-jp/dotfiles.git
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap --yes
mise install
```

`mise install` が別途要るのは、`[tools]` を持つグローバル設定が dotfiles 配布フェーズで初めて
出現するため。mise は起動時に設定を読むので同一実行内では反映されない。

## 変更を検証する

`$HOME` を触らずに配布結果を確かめる手順。

```sh
# 1. 現状のスナップショットを取る
{
  for f in $(find home -type f | sort); do
    rel="${f#home/}"
    printf '%s %s %s\n' "$rel" "$(shasum -a256 "$HOME/$rel" | cut -c1-16)" "$(stat -Lf '%Sp' "$HOME/$rel")"
  done
} > /tmp/before.txt

# 2. サンドボックスへ配布（[settings] を書かない、mode を明示する）
mkdir -p /tmp/sb
cat > /tmp/sb/mise.toml <<EOF
[dotfiles]
"/tmp/sbhome/.config" = { source = "$PWD/home/.config", mode = "copy" }
"/tmp/sbhome/.claude" = { source = "$PWD/home/.claude", mode = "copy" }
EOF
(cd /tmp/sb && mise trust && mise bootstrap dotfiles apply --yes)

# 3. 突き合わせる
{
  for f in $(find home -type f | sort); do
    rel="${f#home/}"
    printf '%s %s %s\n' "$rel" "$(shasum -a256 "/tmp/sbhome/$rel" | cut -c1-16)" "$(stat -f '%Sp' "/tmp/sbhome/$rel")"
  done
} > /tmp/after.txt
diff /tmp/before.txt /tmp/after.txt
```

サンドボックスへの apply でも**グローバル設定のエントリは評価される**。実行前に
`mise bootstrap dotfiles status` で既存エントリが `applied` であることを確認しておくこと。
`differs` のまま実行すると no-op にならず実機が変わる。

## 参照

- 設計: `docs/superpowers/specs/2026-08-15-worktree-copy-distribution-design.md`
- 実装計画: `docs/superpowers/plans/2026-08-15-worktree-copy-distribution.md`
- chezmoi からの移行経緯: `docs/superpowers/plans/2026-08-15-chezmoi-to-mise-bootstrap.md`

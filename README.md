# dotfiles

macOS のマシンセットアップを [mise](https://mise.jdx.dev/bootstrap.html) で管理する public リポジトリ。
アプリの設定ファイルの正本は、実機のファイルと private な
[`raba-jp/dotfiles-history`](https://github.com/raba-jp/dotfiles-history) に分離している。

## 管理範囲

| 場所 | 管理するもの |
| --- | --- |
| このリポジトリの `mise.toml` | Homebrew パッケージ、macOS defaults、fish 初期化タスク |
| `~/.config/mise/config.toml` | ツール、環境変数、wrapper などのグローバル設定。private 履歴で管理 |
| `~/.config/mise/conf.d/dotfiles-tracking.toml` | ファイル単位の追跡許可リストと watcher。private 履歴で管理 |
| `~/.config/mise/config.local.toml` | マシン固有の history origin。追跡しない |
| `scripts/colortest.sh` | リポジトリ内で直接実行する補助スクリプト |

`home/` と copy 配布は撤去済み。このリポジトリから実機のアプリ設定を上書きしたり、
実機の変更を `cp` で public リポジトリへ戻したりしない。
このリポジトリを clone するだけでは、個人設定は復元されない。

## 新しい Mac のセットアップ

Homebrew がインストール済みであることを前提とする。

### 1. GitHub 認証と private 設定の復元

```sh
brew install mise gh
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git --hostname github.com
MISE_EXPERIMENTAL=1 mise bootstrap --adopt https://github.com/raba-jp/dotfiles-history.git --only dotfiles
mise install
mise bootstrap services apply --dry-run
mise bootstrap services apply
mise dot status
```

`--only dotfiles` で設定の復元に限定し、パッケージ・macOS defaults・サービスは同時に適用しない。
復元後にツールをインストールし、内容を確認してから watcher を登録する。
`--adopt` は同じ共有履歴への参加に使う。既存マシンで別の初期履歴を作ってから同じ origin に
接続しない。既存ファイルに差分がある場合は、退避・内容確認を行い、強制上書きしない。

認証は通常の `gh auth login` セッションを使う。Git の credential helper が
`gh auth git-credential` を呼ぶため、設定ファイルや URL にトークンを書かない。
GitHub 用のトークンを Proton Pass から取得したり、`GH_CONFIG_DIR` を差し替えたりしない。

### 2. マシンセットアップ定義の適用

```sh
mise exec -- ghq get https://github.com/raba-jp/dotfiles.git
cd ~/ghq/github.com/raba-jp/dotfiles
mise trust
mise bootstrap --yes
```

ここでの `mise bootstrap` は **Homebrew パッケージと macOS defaults を変更する**。
アプリ設定の copy 配布は行わないが、グローバル設定で宣言された watcher も適用される。
必要な場合だけ、別途 `mise run bootstrap` で fisher / fish プラグインを初期化する。

## 日常の設定変更と同期

Zed、Claude Code、Ghostty、fish、Git、mise、OmniWM などの設定は実ファイルを直接変更する。
watcher が許可リストのファイルだけを保存し、private origin へ push・取得・反映する。
checkout の場所や存続には依存しない。

```sh
mise dot paths
mise dot status
mise bootstrap services status
mise dot history --path ~/.config/zed/settings.json
```

すぐに保存・送信したい場合は次を使う。`sync` だけでは未保存の変更を checkpoint に含めない。

```sh
mise dot save
mise dot sync
```

`mise dot sync` は保存済み履歴の送受信だけを行い、実ファイルは書き換えない。
取得済みの変更を今すぐ反映する操作は `mise dot pull`。これはファイルを書き換えるので、
先に `mise dot status` で差分・競合を確認する。通常は watcher が自動で反映する。

2026.10.17 の実機設定では、push の間隔は `5m`、取得の間隔は `15m`。
現在値は `mise settings get history.sync_interval` と
`mise settings get history.fetch_interval` で確認できる。

### 追跡対象の追加

`~/.config/mise/conf.d/dotfiles-tracking.toml` の `[dotfiles]` に、公開・共有してよい設定を
ファイル単位で追加し、各エントリに `mode = "track"` を明示する。その設定ファイル自身も
private 履歴に入る。`mise dot paths` で対象を確認する。

- `~/.config` や `~/.claude` 全体を追跡しない。
- `gh/hosts.yml`、Claude の認証情報、`~/.claude.json`、mise の `config.local.toml` を追跡しない。
- private でも秘密は入れない。一時的な編集も checkpoint に残り、後から除外しても過去の履歴は消えない。
- `mise dot track` や `mise bootstrap dotfiles add` ではなく、専用の追跡ファイルを編集する。
- ツール設定は `~/.config/mise/config.toml` に置く。public 側に同じ設定を複製しない。

### 停止・障害時

```sh
mise dot status
mise doctor
```

競合・未保存の変更・認証失敗を確認する。競合がある場合は push と受信内容の適用が止まる。
ネットワーク障害時もローカル保存は継続する。
実機の Homebrew 版 2026.10.17 ではデスクトップ通知が利用できないため、通知だけに頼らない。

自動通信だけを停止するには `mise settings history.sync=manual`。
watcher 自体を停止・削除するには `mise bootstrap services remove mise-history`。
履歴と追跡宣言は残るため、次の `mise bootstrap services apply` で再び起動する。

## macOS defaults

このリポジトリ内で確認・適用する。

```sh
mise bootstrap macos defaults status
mise bootstrap macos defaults apply --dry-run
mise bootstrap macos defaults apply
```

GUI で変更した後、`defaults read <domain> <key>` で実際のキーと型を確認し、`mise.toml` を更新する。
エントリを削除しても実機の値は消えない。反映にアプリ再起動やログアウトが必要な設定もある。

## 移行・検証記録

[private 履歴への移行設計と検証結果](docs/superpowers/specs/2026-11-16-private-dotfiles-history-design.md) を参照。
それ以前の `docs/superpowers/` の設計・計画は、chezmoi / copy 配布時代の履歴資料である。

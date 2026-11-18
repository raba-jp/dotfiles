# Agent Instructions

macOS の個人マシンセットアップを mise で管理する **public** リポジトリ。
アプリの設定ファイルの正本は実 `$HOME` と private な `raba-jp/dotfiles-history` にある。

## 管理境界

| 場所 | 内容 |
| --- | --- |
| `mise.toml` | パッケージ、macOS defaults、fish 初期化タスク。project config |
| `scripts/colortest.sh` | 配布しない補助スクリプト |
| `~/.config/mise/config.toml` | ツール・環境変数・wrapper。private 履歴で管理 |
| `~/.config/mise/conf.d/dotfiles-tracking.toml` | 明示的な track 許可リストと watcher。private 履歴で管理 |
| `~/.config/mise/config.local.toml` | このマシンだけの origin 接続情報。追跡しない |

`home/` と copy 配布は撤去済み。public リポジトリに実機設定のコピーや配布元を再導入しない。
checkout を削除しても実ファイル・履歴・watcher は壊れない。
実機の変更を public リポジトリへ `cp` で取り込む旧運用は行わない。

## 実機を変更する操作

次の操作はユーザーが明示的に依頼した範囲でのみ実行する。実行前に内容差と対象を確認する。

| コマンド | 影響 |
| --- | --- |
| `mise bootstrap` | パッケージ・macOS defaults・グローバル宣言のサービスを適用 |
| `mise bootstrap packages apply` | Homebrew パッケージをインストール |
| `mise bootstrap macos defaults apply` | 実機の `defaults` を変更 |
| `mise bootstrap services apply` / `remove` | LaunchAgent を作成・起動、または停止・削除 |
| `mise run bootstrap` | `fisher update` で fish プラグインを再構成 |
| `mise bootstrap --adopt ...` | 共有履歴の設定ファイルを実機へ復元 |
| `mise dot save` / `sync` / `origin set` | 履歴の保存や、private origin への送信・接続 |
| `mise dot pull` / `rollback` / `undo` | 実機ファイルを書き換える |

`status` / `paths` / `history` は読み取り専用。`apply --dry-run` で適用内容を確認できる。
`mise bootstrap dotfiles add` と `chezmoi` コマンドは使わない。
`dotfiles add` は既存ファイルを移動し、グローバル設定を書き換えることがある。
通常の設定変更に `mise bootstrap dotfiles apply` は不要。

## 絶対に壊してはいけない不変条件

- public の `mise.toml` に `[dotfiles]` や `dotfiles.default_mode` を追加しない。
- グローバルの `~/.config/mise/config.toml` にも `[dotfiles]` や `dotfiles.default_mode` を書かない。
  mise の `[settings]` は階層をまたいでマージされ、別設定の適用モードを変える危険がある。
- 追跡設定は専用の `conf.d/dotfiles-tracking.toml` に置き、各エントリの `mode = "track"` を明示する。
  `source`、配布用エントリ、`dotfiles.default_mode` は持たせない。
- `mise dot track` はグローバル設定を変更するので使わず、専用ファイルを編集する。
- ツール・wrapper・環境変数は private 側のグローバル設定で管理し、public 側に複製しない。
- 認証情報や実機のレビュー前の設定を、この public リポジトリへ書き込まない。

## 自動保存・双方向同期

実ファイルを `track` モードで保存し、専用 private origin と同期する。
watcher はグローバル設定から起動するため、配布元 checkout を必要としない。

- 現行の許可リストは13ファイル。追加・削除は実機の専用追跡ファイルで行う。
- `~/.config` や `~/.claude` 全体を追跡しない。
- `gh/hosts.yml`、Claude の認証情報、`~/.claude.json`、mise の `config.local.toml` を追跡しない。
- private でも秘密は入れない。一時的な編集も保存され、除外しても過去の checkpoint は消えない。
- **この public リポジトリを history origin に指定しない。** 接続先の変更や公開を勝手に行わない。
- GitHub 認証は通常の `gh auth login` セッションを使う。Proton Pass から GitHub トークンを取得せず、
  `GH_CONFIG_DIR` を差し替えず、トークンを設定や URL に書かない。
- watcher からも Git の credential helper が利用できることを確認する。
- 既存マシンは同じ共有履歴を adopt する。別々の初期履歴を作って同じ origin に接続しない。

```sh
mise dot paths
mise dot status
mise bootstrap services status
```

障害時は `mise dot status` と `mise doctor` を確認する。
実機の Homebrew 版 2026.10.17 はデスクトップ通知が利用できないので、通知だけに頼らない。
サービスを削除しても宣言と履歴は残り、次の services apply で再起動する。

## macOS のシステム設定

`mise.toml` の `[bootstrap.macos.defaults]` は `defaults write` の宣言。
curated セクション（`[bootstrap.macos.dock]` など）は使わず、domain と key を直接指定する。

```sh
mise bootstrap macos defaults status
mise bootstrap macos defaults apply --dry-run
```

`status` の3列目が設定したい値、4列目が現在値、5列目が `set` / `differs` / `unset`。
追加・変更は GUI 操作後に `defaults read <domain> <key>` で実際のキーと型を確認する。

- 型を推測しない。`com.apple.menuextra.clock` の `ShowDate` は bool ではなく int の enum。
- `KeyRepeat` は macOS が float で保持するため float で宣言する。
- エントリ削除に prune はない。必要なら明示的な依頼のもと `defaults delete` する。
- アプリ再起動やログアウトが必要な設定がある。mise は `killall Dock` などを実行しない。
- サードパーティ tap のパッケージは API メタデータと `status` / `apply --dry-run` で対応を確認する。

## 新規マシン

README の順序に従い、GitHub 認証 → private 履歴の adopt（`--only dotfiles`）→ ツールと watcher →
この public リポジトリのマシンセットアップ、の順に行う。
既存ファイルがある場合は差分・バックアップを確認し、無条件に上書きしない。

## 変更の検証

実機の設定を変更する前に owner-only のバックアップを作り、内容・実行ビット・所有者を維持する。
配布・履歴・復元・同期を検証する際は、環境を継承しない専用プロセスで以下を隔離する。
ターゲットを `/tmp` に変えるだけでは、グローバル設定の実機ファイルが履歴に保存され得る。

- `HOME` と作業ディレクトリ
- `XDG_CONFIG_HOME` / `XDG_CACHE_HOME` / `XDG_DATA_HOME` / `XDG_STATE_HOME`
- `MISE_CONFIG_DIR` / `MISE_SYSTEM_CONFIG_DIR` / `MISE_CACHE_DIR` / `MISE_DATA_DIR` /
  `MISE_STATE_DIR` / `MISE_TMP_DIR`
- Git は `GIT_CONFIG_NOSYSTEM=1`、`GIT_CONFIG_GLOBAL=/dev/null` と検証専用 author / committer を指定

検証用 project config に `[settings]` を書かない。copy を検証する場合も各エントリの mode を明示する。
サービスの検証は `mise bootstrap services apply --dry-run` のみにし、実機 launchd へ登録しない。
実機 watcher の検証はユーザーが設定・起動を依頼したときに限る。
private からの復元確認は owner-only の退避先へ取得したコピーを使い、隔離環境へ Git 認証を継承しない。

確認項目:

1. 許可した実ファイルだけが保存され、認証・状態ファイルが含まれない
2. watcher が変更を保存し、設定済みの認証で private origin へ送れる
3. `mise bootstrap --adopt <file-url> --only dotfiles` で内容・権限を復元できる
4. 隔離した2環境と `/tmp` の bare origin で往復同期できる
5. 検証後に実機の内容・権限が意図せず変わっていない

macOS defaults は書き換え先を差し替えられないため、`status` と `apply --dry-run` で検証する。
`--dry-run` の domain・key・型を確認し、検証のために実機へ書き込まない。

## 参照

- 現行設計: `docs/superpowers/specs/2026-11-16-private-dotfiles-history-design.md`
- `docs/superpowers/` の過去の copy / chezmoi 設計・計画は履歴資料。現行の配布手順として使わない

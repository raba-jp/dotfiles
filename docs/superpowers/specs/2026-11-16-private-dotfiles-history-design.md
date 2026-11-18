# Private dotfiles history

2026-11-15 に実機設定のレビュー・整理と private 履歴への移行を開始し、2026-11-16 に
public 側の二重管理の撤去と運用手順の更新を行った。mise 2026.10.17 / macOS で検証。

## 決定

アプリ設定の正本は実ファイルと private な `raba-jp/dotfiles-history` とする。
public の `raba-jp/dotfiles` はマシンセットアップ定義だけを管理する。
アプリ設定を public の `home/` と private 履歴の両方で管理しない。

| 対象 | 所在 |
| --- | --- |
| パッケージ / macOS defaults / fish 初期化タスク | public の `mise.toml` |
| ツール / 環境変数 / wrapper | private 履歴内のグローバル `config.toml` |
| track 許可リスト / watcher | private 履歴内の `conf.d/dotfiles-tracking.toml` |
| origin URL / 同期モード | 実機の `config.local.toml`。共有しない |

実ファイルは symlink に変更しない。watcher はグローバル設定で動作し、checkout に依存しない。

## 実機レビュー後の整理

- OpenCode は npm 版の v2 系を選択し、v2.2.6 の実行を確認。旧 aqua エントリを削除。
- mise の PATH 追加はユーザー名固定ではなく `{{ env.HOME }}` を使用。
- 既存の cargo wrapper、ビルド許可、mr-boxington の固定バージョンを維持。
- `github_attestations = true` に変更。
- 未使用の Sketchybar / WezTerm 設定7ファイルを、バックアップ後に実機と public から削除。
- Pencil の許可と MCP 登録は別の Wefto 用 T3 スレッドで local scope へ移行。
  Wefto 固有の local settings や `~/.claude.json` はグローバルな dotfiles 履歴へ追加しない。

## 保存・同期

`~/.config/mise/conf.d/dotfiles-tracking.toml` で、設定ファイル13個を個別に追跡する。
許可リスト自身を含み、各エントリに `mode = "track"` を明示する。
メインのグローバル設定と public の project config に `[dotfiles]` / `dotfiles.default_mode` は置かない。

origin は private リポジトリの `main`、同期モードは `sync`。
認証は通常の `gh auth login` セッションと Git の `gh auth git-credential` ヘルパーを使用する。
GitHub トークンの取り出し・ファイルへの転記・URL 埋め込みは行わない。

macOS の watcher は `~/Library/LaunchAgents/dev.mise.mise-history.plist` として登録する。
実機では、起動後の watcher 自身の取得・公開が認証エラーなしで成功した。
push / fetch の現在値は `5m` / `15m`。Homebrew 版のデスクトップ通知は利用できないため、
`mise dot status` / `mise doctor` で競合や通信エラーを確認する。

## 移行の順序と実施結果

1. private origin が空、実機の checkpoint が0、watcher が未登録であることを確認。
2. 既存の実ファイル12個、public の `home/`、設定・履歴を owner-only の永続バックアップへ保管。
3. 追跡予定ファイルの既知のトークン・秘密鍵・認証 URL・認証値代入パターンを確認し、該当なし。
   この確認は、あらゆる秘密が存在しないことを保証するものではない。
4. 専用の追跡設定を配置し、13ファイルと mise メタデータだけを含む初回 checkpoint を確認。
5. private origin へ接続・初回送信し、LaunchAgent を起動。
6. bat 設定への無害な空行追加と原状復帰が、watcher により両方とも自動保存されることを確認。
   最終的な bat 設定はバックアップと byte 単位で一致。
7. private origin を owner-only の退避先へ読み戻し、そのコピーから完全隔離環境へ adopt。
8. 全13ファイルの内容と権限の一致を確認してから、public の `home/` と copy 設定を撤去。

復元確認では `HOME`、XDG / mise の全 config・cache・data・state、作業ディレクトリ、Git 設定を
隔離した。GitHub 認証を継承せず、取得済みのローカル bare repository を使った。
`--only dotfiles` によりサービス・パッケージ・macOS defaults は適用しなかった。

確認結果:

- 全13ファイルを通常ファイルとして復元し、byte・mode が一致。
- mise のメイン設定と追跡設定の `0600` を保持。
- GitHub / Claude の認証ファイル、`~/.claude.json` を保存・復元していない。
- 復元先の LaunchAgent は未登録。
- 事前の隔離した2環境とローカル bare origin の検証でも、自動保存・往復同期・許可リスト外の除外に成功。
- 実機では古い mise コメントの削除と追跡設定・origin・サービスの新設以外、既存設定の内容・権限を維持。
- public のパッケージ / macOS defaults / fish 初期化タスクは変更していない。

バックアップは実機の `~/.local/state/dotfiles/backups/` 以下に保管し、public リポジトリには入れない。
public 側の変更は作業 checkout にあり、この移行作業では commit / push しない。
過去の public Git 履歴を書き換える作業も行わない。

## 継続運用

設定変更は実ファイルへ行う。許可リストやツール設定も private 側だけを更新する。
private であっても秘密は保存せず、ディレクトリ全体の追跡は行わない。
復元と新規マシンのセットアップは README の手順に従う。
それ以前の copy / chezmoi の設計・計画は履歴資料であり、現在の運用には適用しない。

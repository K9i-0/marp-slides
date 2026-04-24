# 概要

- React Native & Flutter Meetup
- 10分程度
- Flutter LT枠

## タイトル等

タイトル
AI駆動開発した個人開発Flutterアプリが500スター超えたのでその時の知見を共有します
名前
Kota Hayashi K9i a.k.a. たこさん
所属
ゆめみ

## 自己紹介

10秒目安
軽くTwitterのプロフを紹介して終わり
<https://x.com/K9i_apps>

## 作ったアプリについて

1分目安
CodexやClaudeをスマホから操作するためのアプリ
ターミナル操作系のアプリではなく、ネイティブの体験が欲しくなり開発
<https://github.com/K9i-0/ccpocket>
3/6にiOS版を公開
GitHubスター数 626
App Storeレビュー(日本語) 21件 星 4.8/5
Google Playのレビュー 10件 星 5/5
QRコードからチェックしてね

## 利用したAIツール

Claude Code、Codex、Antigravityの３つを併用

### メイン

Claude Code、Codexで設計から実装、環境構築までほとんど実施
初期はClaude Codeを利用、今はCodexに乗り換え済み

1. Claude Max $100
2. Claude Max $100 + Codex Plus $20
3. Claude Pro $20 + Codex Pro $100
4. Codex Pro $100

ツールの機能差はあるが、どちらもモデル性能は十分
理由はコスパ
同じ料金ならCodexが遥かに利用枠が多い
どちらも$20, $100, $200のプランがあるが、CodexはClaudeの１ランク上のプランくらい使える
また、Claudeはサードパーティツールでの利用が規約違反になった、Codexはサードパーティにも寛容

### デザイン担当

Antigravity
Geminiがマルチモーダルを売りにしているモデルなので、ビジュアルに強い
生成するコードの品質は微妙だが、コードも書けるデザイナーだと思うと結構有能
アプリアイコン等の素材生成、機能的には出来上がってるUIの最終ブラッシュアップなどで重宝
CC PocketはUI/UXが好評だが、UIは間違いなくAntigravityのおかげ

## AI以外の技術スタック

Flutter（タイトル的に当然）
結局自分自身が技術力無いとAIに的確な指示が出せない
確かに触ったこと無い技術を試すハードルは下がったが、思い通りに機能を作ろうと思うと使い慣れた技術がいい
モバイル開発経験ない人ならReact Native x ExpoのほうがAI系のエコシステムが充実してそうなので勧めるかも
marionette mcp
UI検証をAI自身にやらせるのが重要
Flutterだとmarionette mcpがおすすめ
shorebird
AIでスマホでの開発が現実的になってる、そうすると遠隔でも実機確認する方法が欲しくなる
OTA的な仕組みは非常に便利
（ぶっちゃけExpoのほうが優れてそう）
BLoC
断言できるレベルではないが、自由度が高い状態管理はAIで使いづらい（Riverpod）
あとコード生成がテンポ悪い
gh actions
特にワークスペースの作成中などエラーをAPIで取れるのはマスト
最初CodeMagicを試したけど、cliやrest apiからエラーの詳細が取れないぽくてだめだった

## まとめ

AI駆動で個人アプリを作ってみたときの知見共有でした

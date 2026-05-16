# Codex Appとの連携経路を調べた話

3分LT用ドラフト。

## ねらい

CC Pocketはこれまで独自に `codex app-server` を立ち上げてCodexをリモート操作していた。
ただしこの方式では、公式のCodex Appが見ているセッション世界とは分かれてしまう。

そこで、公式Codex mobileがどうCodex Appと連携しているのか、そしてLitterというアプリがなぜ連携できているように見えるのかを調べた、という話。

## スライド案

### 1. CC Pocketは独自app-serverで動いていた

- CC PocketはCodexやClaudeをスマホから操作するリモートコントロールアプリ
- Codex側はBridgeが独自に `codex app-server` を起動して接続していた
- この方式でもセッション開始、承認、diff確認などはできる
- ただし、公式Codex Appが内部で持っているセッションとは同期しない

発表者ノート:

> CC Pocketというアプリを作っています。  
> CodexやClaudeをスマホから操作するためのリモートコントロールアプリです。  
> Codexについては、Bridgeが独自に `codex app-server` を立ち上げて、そこへ接続する形で動かしていました。  
> これでもCodexの操作はできますが、公式Codex Appが見ているセッションとは別世界になります。

### 2. でもCodex Appとは連携できない

- `app-server` はrich client向けの仕組み
- なので一見、Codex Appの `app-server` に外から接続できそうに見える
- しかし調査した範囲では、Codex App内部の `app-server` に後から入る方法は見つからなかった
- local TCP portではなく、stdio / Unix fd系でアプリ内部から直接つながっているように見えた

観測:

- Codex Appは内部で `codex app-server` をchild processとして起動していた
- `ws://localhost:port` のような外部接続口は見つからなかった
- Codex Appに「外部app-server URLを指定して接続する」導線も見つからなかった

発表者ノート:

> ここで自然に考えるのは、じゃあCodex Appが使っているapp-serverに外から入れないのか、ということです。  
> ただ、調べた範囲では難しそうでした。  
> Codex Appは内部で `codex app-server` を起動しているのですが、ローカルのTCP portを開いている感じではありません。  
> Electron側とchild processがstdioやUnix fd系で直接つながっているように見えました。

### 3. 公式Codex mobileはCodex Appと連携できる

- OpenAIはChatGPT mobile appにCodex remote accessを追加した
- ChatGPT mobile appから、Mac上のCodex App / Codex環境へ接続できる
- mobile側はlive context、承認、diff、terminal output、test resultなどを扱える
- つまり公式は、Codex App側の状態へ深く接続できている

発表者ノート:

> 一方で、公式Codex mobileはCodex Appと連携できます。  
> ChatGPT mobile appからMac上のCodex環境に接続して、live context、承認、diff、terminal output、test resultまで扱える。  
> これは独自app-server方式よりずっと体験が強いです。  
> 公式が何らかのremote-control経路でCodex App側の状態に入れている、ということになります。

### 4. Litterも連携できている？

- Litterというアプリが、Codex App / 公式側と連携できているように見える
- 単純なローカル `app-server` 接続ではなさそう
- Codex Appの `Connections` / remote control系の仕組みが関係していそう
- OpenAI側のremote-control backendに登録されたclientとして接続するモデルに見える

簡略モデル:

```text
mobile app
  -> OpenAI remote-control authorization
  -> Codex App / app-server transport
  -> Codex thread/session
```

発表者ノート:

> そこで気になったのがLitterです。  
> Litterというアプリが、Codex Appや公式側と連携できているように見えます。  
> これが本当にそうなら、単純に独自app-serverを立てているのではなく、Codex AppのConnectionsやremote control周辺の仕組みに乗っている可能性が高い。  
> ざっくり言うと、mobile appがOpenAI側のremote-control認可を通り、そこからCodex Appやapp-server transportにつながるモデルに見えます。

### 5. client idが必要そうなので問い合わせた

- remote-controlに参加するには、外部クライアント用の `client id` のような登録情報が必要そう
- その接続口がサードパーティに開かれているのかは、公開情報だけでは判断できない
- そこでOpenAIに問い合わせた
- 知りたいこと:
  - サードパーティアプリがCodex remote-controlに参加してよいか
  - 必要な `client id` や登録手続きはあるか
  - 利用可能な場合、安定性・認証・サポート範囲はどうなるか

発表者ノート:

> 調べた限り、鍵になりそうなのは `client id` です。  
> remote-controlに参加する外部クライアントとして、OpenAI側に登録された識別子が必要そうに見えました。  
> ただ、その接続口がサードパーティに開かれているのか、どこまで使ってよいのかは公開情報だけでは判断できません。  
> なのでOpenAIに問い合わせました。

## まとめ

- CC Pocketの独自 `app-server` 方式では、Codex操作はできるがCodex Appとは同期できない
- Codex App内部の `app-server` に後から接続する方法は見つからなかった
- 公式Codex mobileは、remote-control経路でCodex App側の状態に入っているように見える
- Litterもその経路に乗っている可能性がある
- `client id` が必要そうなので、OpenAIに問い合わせ中

## 3分用スクリプト

CC Pocketというアプリを作っています。CodexやClaudeをスマホから操作するリモートコントロールアプリです。Codexについては、これまでBridgeが独自に `codex app-server` を立ち上げて、そこへ接続していました。これでもセッション開始、承認、diff確認などはできます。

ただ、この方式には大きな限界があります。公式Codex Appが見ているセッションとは同期しません。つまり、CC Pocket側で動かしているCodexと、Codex App側の状態が別世界になってしまいます。

そこでまず考えたのは、Codex Appが内部で使っている `app-server` に外から接続できないか、ということです。`app-server` はrich client向けの仕組みなので、一見そこに入れれば良さそうに見えます。

しかし調べた範囲では、Codex App内部の `app-server` に後から入る方法は見つかりませんでした。Codex Appはchild processとして `codex app-server` を起動していましたが、ローカルのTCP portをlistenしている形ではなく、Electron側とstdioやUnix fd系で直接つながっているように見えました。

一方で、公式Codex mobileはCodex Appと連携できます。ChatGPT mobile appからMac上のCodex環境に接続して、live context、承認、diff、terminal output、test resultまで扱える。独自app-server方式よりずっと強い体験です。

さらに、LitterというアプリもCodex Appや公式側と連携できているように見えます。もしそうなら、単純に独自app-serverを立てているのではなく、Codex AppのConnectionsやremote control周辺の仕組みに乗っている可能性が高いです。mobile appがOpenAI側のremote-control認可を通り、そこからCodex Appにつながる、というモデルに見えます。

そうなると鍵になりそうなのは `client id` です。remote-controlに参加する外部クライアントとして、OpenAI側に登録された識別子が必要そうに見えました。ただ、その接続口がサードパーティに開かれているのか、どこまで使ってよいのかは公開情報だけでは判断できません。

なのでOpenAIに問い合わせました。サードパーティアプリがCodex remote-controlに参加してよいのか。必要な `client id` は提供されるのか。使える場合、安定性、認証、サポート範囲はどうなるのか。今日はその調査途中の話でした。

## 参考リンク

- OpenAI: Work with Codex from anywhere  
  https://openai.com/index/work-with-codex-from-anywhere/
- OpenAI Help Center: ChatGPT release notes  
  https://help.openai.com/en/articles/6825453-chatgpt-release-notes
- OpenAI Help Center: Using Codex with your ChatGPT plan  
  https://help.openai.com/en/articles/11369540-codex-in-chatgpt
- Litter  
  https://kittylitter.app/

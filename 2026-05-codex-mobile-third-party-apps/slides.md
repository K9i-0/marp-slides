---
marp: true
theme: custom
paginate: true
lang: ja
title: "Codex Mobile時代のサードパーティアプリの立ち位置"
description: "Codex mobile登場後に、CC Pocketのようなサードパーティアプリがどこで価値を出すべきかを整理する3分LT"
footer: "Codex Mobile時代のサードパーティアプリ — 2026/05/16"
---

<!-- _class: title -->
<!-- _paginate: false -->

# Codex Mobile時代の

# サードパーティアプリの立ち位置

## 公式と競うより、つながる・作り替える

### Kota Hayashi

---

## 自己紹介

<div style="display: grid; grid-template-columns: 0.9fr 1.1fr; gap: 42px; align-items: start;">
  <div>
    <h3>Kota Hayashi</h3>
    <ul>
      <li>K9i a.k.a. たこさん</li>
      <li>所属: ゆめみ</li>
      <li>Flutter歴: 業務だと5年くらい</li>
      <li>X: <a href="https://x.com/K9i_apps">https://x.com/K9i_apps</a></li>
    </ul>
  </div>
  <div>
    <h3>最近やっていること</h3>
    <ul>
      <li><strong>CC Pocket</strong> を開発中</li>
      <li>Codex / Claude をスマホから操作するアプリ</li>
      <li>Flutterで iOS / Android / macOS に対応</li>
      <li>GitHub: <a href="https://github.com/K9i-0/ccpocket">K9i-0/ccpocket</a></li>
    </ul>
  </div>
</div>

---

## 事件: Codex mobileが出た

# 「スマホから触れる」だけでは弱くなった

<div style="font-size: 1.05em; margin-top: 26px;">

- CC Pocketは「モバイルでCodexを使える」が大きな価値だった
- 公式が出ると、そこは正面から競う場所ではなくなる
- ではサードパーティアプリの価値はどこに残るのか？

</div>

---

## 考え直したポイント

# 同じセッション世界に入れるか

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 34px; align-items: start; margin-top: 20px;">
  <div>
    <h3>ユーザーが期待すること</h3>
    <ul>
      <li>同じ履歴を見たい</li>
      <li>実行中のturnを追いたい</li>
      <li>承認フローを壊したくない</li>
    </ul>
  </div>
  <div>
    <h3>公式が強いところ</h3>
    <ul>
      <li>Codex Appとの同期</li>
      <li>通知と画面更新</li>
      <li>認証とownership</li>
    </ul>
  </div>
</div>

<div style="margin-top: 30px; text-align: center; font-size: 1.16em;">
  UIの差より、公式の作業状態とつながれるかが大きい
</div>

---

## 掘ってみると接続口は見えている

<div style="display: grid; grid-template-columns: 1.05fr 0.95fr; gap: 36px; align-items: center;">
  <div style="display: grid; gap: 12px;">
    <div style="border: 2px solid #1e88e5; border-radius: 10px; padding: 14px 18px;">
      <strong>CC Pocket</strong>
      <div style="font-size: 0.72em; color: #555;">mobile / desktop app</div>
    </div>
    <div style="text-align: center; color: #555;">↓ WebSocket</div>
    <div style="border: 2px solid #43a047; border-radius: 10px; padding: 14px 18px;">
      <strong>Bridge</strong>
      <div style="font-size: 0.72em; color: #555;">Mac上のローカルサービス</div>
    </div>
    <div style="text-align: center; color: #555;">↓ stdio / socket / proxy</div>
    <div style="border: 2px solid #f9ab00; border-radius: 10px; padding: 14px 18px;">
      <strong>codex app-server</strong>
      <div style="font-size: 0.72em; color: #555;">thread / turn / event</div>
    </div>
  </div>
  <div>
    <ul>
      <li>rich client向けの層がある</li>
      <li>thread開始、turn開始、イベント購読を扱える</li>
      <li>CC PocketでもBridgeから接続する実装を進めている</li>
    </ul>
  </div>
</div>

---

## ただし、ここで止まった

# 「動く」と「提供してよい」は別

<div style="font-size: 1.04em; margin-top: 28px;">

- Codex App / Codex mobileと同じセッションに参加できる公式な方法はあるか
- `app-server` / remote-control APIを外部クライアントが使ってよいか
- 使える場合、安定性・認証・サポート範囲はどうなるか

</div>

<div style="margin-top: 40px; text-align: center; font-size: 1.28em;">
  ここは推測で決めず、OpenAIに問い合わせ中
</div>

---

<!-- _class: dark -->

## 今の判断

# 公式と正面から競わない

<div style="font-size: 1.03em;">

- 公式に接続できるなら、その世界に乗る
- 難しいなら、公式クライアントの代替を目指さない
- MITライセンスのOSSカスタム基盤へ寄せる
- Jira / Linear / GitHub / 社内APIなどを組み込みやすくする

</div>

<div style="margin-top: 34px; font-size: 1.28em; text-align: center;">
  単なるクライアントではなく、仕事に合わせて作り替えられる<br />
  エージェントUI基盤を目指す
</div>

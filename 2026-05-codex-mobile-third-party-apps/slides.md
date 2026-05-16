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

## Codex mobileが出た

<div style="font-size: 1.06em;">

- 公式モバイルクライアントが登場
- 「スマホからCodexを触れる」だけでは差別化しにくい
- サードパーティアプリの役割が変わった

</div>

<div style="margin-top: 46px; font-size: 1.45em; text-align: center;">
  ただし、意味がなくなったわけではない
</div>

---

## 本当に大きい差分

# 同じセッション世界に入れるか

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 34px; align-items: start; margin-top: 24px;">
  <div>
    <h3>公式が強いところ</h3>
    <ul>
      <li>履歴</li>
      <li>実行状態</li>
      <li>承認フロー</li>
      <li>通知と画面更新</li>
    </ul>
  </div>
  <div>
    <h3>サードパーティの壁</h3>
    <ul>
      <li>同じthreadを見られるか</li>
      <li>作業中のturnを追えるか</li>
      <li>片方の操作がもう片方に反映されるか</li>
    </ul>
  </div>
</div>

---

## 技術的には、接続口が見えている

<div style="display: grid; grid-template-columns: 1.05fr 0.95fr; gap: 36px; align-items: center;">
  <div style="display: grid; gap: 12px;">
    <div style="border: 2px solid #1e88e5; border-radius: 10px; padding: 14px 18px;">
      <strong>Third-party app</strong>
      <div style="font-size: 0.72em; color: #555;">CC Pocketなど</div>
    </div>
    <div style="text-align: center; color: #555;">↓ WebSocket / local bridge</div>
    <div style="border: 2px solid #43a047; border-radius: 10px; padding: 14px 18px;">
      <strong>Bridge / local service</strong>
      <div style="font-size: 0.72em; color: #555;">自前の中継プロセス</div>
    </div>
    <div style="text-align: center; color: #555;">↓ stdio / socket / proxy</div>
    <div style="border: 2px solid #f9ab00; border-radius: 10px; padding: 14px 18px;">
      <strong>codex app-server</strong>
      <div style="font-size: 0.72em; color: #555;">thread / turn / notification</div>
    </div>
  </div>
  <div>
    <ul>
      <li>rich client向けの層がある</li>
      <li>JSON-RPC風にセッションやイベントを扱える</li>
      <li>CC PocketでもBridgeから接続する実装を進めている</li>
    </ul>
  </div>
</div>

---

## でも、ここは分けて考える

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px; align-items: stretch;">
  <div style="border: 2px solid #43a047; border-radius: 10px; padding: 22px;">
    <h3>動くか</h3>
    <ul>
      <li>app-serverにつながる</li>
      <li>threadを開始できる</li>
      <li>通知を購読できる</li>
    </ul>
  </div>
  <div style="border: 2px solid #e53935; border-radius: 10px; padding: 22px;">
    <h3>提供してよいか</h3>
    <ul>
      <li>公式にサポートされるか</li>
      <li>認証とownershipは安全か</li>
      <li>仕様変更に耐えられるか</li>
    </ul>
  </div>
</div>

<div style="margin-top: 36px; text-align: center; font-size: 1.25em;">
  非公式に動くことと、安心してアプリに入れることは別
</div>

---

## とりあえずOpenAIに聞いた

知りたいこと:

- サードパーティアプリが公式クライアントと同じセッションに参加できるか
- `app-server` / remote-control APIを外部クライアントが使ってよいか
- 使える場合、安定性・認証・サポート範囲はどうなるか

<div style="margin-top: 42px; font-size: 1.25em; text-align: center;">
  ここは推測で突っ走らない
</div>

---

## CC Pocketの方向性

# 公式と正面から競わない

<div style="font-size: 1.02em;">

- 公式に接続できるなら、その世界に乗る
- 難しいなら、MITライセンスのOSSカスタム基盤へ寄せる
- Jira / Linear / GitHub / 社内APIなどを組み込みやすくする

</div>

<div style="margin-top: 42px; font-size: 1.35em; text-align: center;">
  単なるクライアントではなく、仕事に合わせて作り替えられる<br />
  エージェントUI基盤を目指す
</div>

---

<!-- _class: dark -->

## まとめ

- Codex mobileで「スマホ対応」だけの価値は弱くなった
- 差分は、公式セッション世界とつながれるか
- 技術的な可能性と、公式に提供できるかは別問題
- CC Pocketは接続性・改変性・業務統合で価値を出す

<div style="margin-top: 42px; font-size: 1.25em; text-align: center;">
  公式クライアントの代替ではなく、OSSのカスタム基盤へ
</div>

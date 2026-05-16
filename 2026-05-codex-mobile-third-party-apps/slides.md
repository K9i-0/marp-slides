---
marp: true
theme: custom
paginate: true
lang: ja
title: "Codex Appとの連携経路を調べた話"
description: "CC Pocketの独自app-server方式と、公式Codex mobile / Litterが使っていそうなremote-control経路を調べた3分LT"
footer: "Codex Appとの連携経路を調べた話 — 2026/05/16"
---

<!-- _class: title -->
<!-- _paginate: false -->

# Codex Appとの

# 連携経路を調べた話

## app-server と remote-control の違い

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
      <li>Codex / Claudeをスマホから操作するアプリ</li>
      <li>Flutterで iOS / Android / macOS に対応</li>
      <li>GitHub: <a href="https://github.com/K9i-0/ccpocket">K9i-0/ccpocket</a></li>
    </ul>
  </div>
</div>

---

## 2つのモバイル体験

<div style="display: grid; grid-template-columns: 0.95fr 1.05fr; gap: 34px; align-items: center;">
  <div style="text-align: center;">
    <img src="./images/ccpocket.png" alt="CC Pocket mobile screenshot" style="width: 310px; height: 455px; object-fit: cover; object-position: center 45%; border-radius: 18px;" />
    <div style="margin-top: 10px; font-size: 0.72em; color: #555;">CC Pocket: 独自BridgeからCodexを操作</div>
  </div>
  <div style="text-align: center;">
    <img src="./images/codex-mobile.png" alt="OpenAI Codex mobile announcement screenshot" style="width: 465px; height: 455px; object-fit: cover; object-position: top center; border-radius: 14px;" />
    <div style="margin-top: 10px; font-size: 0.72em; color: #555;">公式Codex mobile: ChatGPT mobile appからCodex Appへ</div>
  </div>
</div>

---

## CC Pocketは独自app-serverで動いていた

<div style="display: grid; grid-template-columns: 1.05fr 0.95fr; gap: 36px; align-items: center;">
  <div style="display: grid; gap: 12px;">
    <div style="border: 2px solid #1e88e5; border-radius: 10px; padding: 14px 18px;">
      <strong>CC Pocket</strong>
      <div style="font-size: 0.72em; color: #555;">mobile / desktop app</div>
    </div>
    <div style="text-align: center; color: #555;">↓ WebSocket</div>
    <div style="border: 2px solid #43a047; border-radius: 10px; padding: 14px 18px;">
      <strong>Bridge</strong>
      <div style="font-size: 0.72em; color: #555;">自前の中継プロセス</div>
    </div>
    <div style="text-align: center; color: #555;">↓ 起動して接続</div>
    <div style="border: 2px solid #f9ab00; border-radius: 10px; padding: 14px 18px;">
      <strong>codex app-server</strong>
      <div style="font-size: 0.72em; color: #555;">thread / turn / diff / approval</div>
    </div>
  </div>
  <div>
    <ul>
      <li>セッション開始、承認、diff確認などはできる</li>
      <li>Codex操作のリモートUIとしては成立する</li>
      <li>ただし、公式Codex Appとは別世界になる</li>
    </ul>
  </div>
</div>

---

## でもCodex Appとは同期しない

<div style="font-size: 1.03em;">

- 独自 <code>app-server</code> 方式でもCodex操作はできる
- ただし、公式Codex Appが見ているセッションとは別世界になる
- そこでCodex App内部の <code>app-server</code> に外から入れないか調べた

</div>

観測:

- Codex Appは <code>codex app-server</code> をchild processとして起動
- <code>ws://localhost:port</code> のような外部接続口は見つからなかった
- stdio / Unix fd系でアプリ内部から直接つながっているように見えた

<div style="margin-top: 22px; text-align: center; font-size: 1.18em;">
  Codex App内部へ後入りする入口ではなさそう
</div>

---

## Litterも同じ経路に見える

<div style="display: grid; grid-template-columns: 1fr 1fr; gap: 34px; align-items: center;">
  <div style="display: grid; gap: 14px;">
    <div style="border: 2px solid #1e88e5; border-radius: 10px; padding: 14px 18px;">
      <strong>mobile app</strong>
    </div>
    <div style="text-align: center; color: #555;">↓ authorization</div>
    <div style="border: 2px solid #43a047; border-radius: 10px; padding: 14px 18px;">
      <strong>OpenAI remote-control</strong>
    </div>
    <div style="text-align: center; color: #555;">↓ transport</div>
    <div style="border: 2px solid #f9ab00; border-radius: 10px; padding: 14px 18px;">
      <strong>Codex App / session</strong>
    </div>
  </div>
  <div>
    <ul>
      <li>LitterはCodex App / 公式側と連携できているように見える</li>
      <li>単純なローカル <code>app-server</code> 接続ではなさそう</li>
      <li>Connections / remote control周辺に乗っていそう</li>
      <li>外部クライアント用の <code>client id</code> が必要そう</li>
    </ul>
  </div>
</div>

---

## なのでOpenAIに問い合わせた

<div style="font-size: 1.04em;">

- remote-controlにサードパーティアプリが参加してよいか
- 必要な <code>client id</code> や登録手続きはあるか
- 利用できる場合、安定性・認証・サポート範囲はどうなるか

</div>

<div style="margin-top: 44px; text-align: center; font-size: 1.28em;">
  公開情報だけでは判断できないので確認中
</div>

---

<!-- _class: dark -->

## まとめ

- CC Pocketの独自 <code>app-server</code> 方式ではCodex操作はできる
- ただし、公式Codex Appとは同期できない
- Codex App内部の <code>app-server</code> に後から接続する方法は見つからなかった
- 公式mobileやLitterは <code>remote-control</code> 経路に乗っている可能性が高い
- <code>client id</code> が必要そうなのでOpenAIに問い合わせ中

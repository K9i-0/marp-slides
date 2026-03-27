---
marp: true
theme: custom
paginate: true
footer: "marp-slides intro — 2026/03"
---

<!-- _class: title -->
<!-- _paginate: false -->

# Marpでスライドを管理する

## 1リポジトリ × 複数スライド運用のすすめ

---

## 自己紹介

- 名前: <!-- ここに名前 -->
- 所属: <!-- ここに所属 -->

---

## 😩 スライド管理の悩み

- Google Slides / Keynote がバラバラに散らばる
- バージョン管理できない
- テーマを統一するのが面倒
- テキストベースで差分が見たい

---

## 💡 Marp + Git で解決

| 課題 | 解決策 |
|------|--------|
| 散らばる | **1リポジトリで集約管理** |
| バージョン管理 | **Git で差分管理** |
| テーマ統一 | **共通 CSS テーマ** |
| テキストベース | **Markdown で記述** |

---

## 🚀 ワークフロー

```text
1. npm run new -- my-topic    # テンプレートからコピー
2. slides.md を編集            # Markdownでスライド作成
3. npm run dev -- my-topic    # ライブプレビュー
4. git push                   # GitHub Actionsが自動ビルド
   → HTML → GitHub Pages
   → PDF  → Artifacts（Speaker Deck用）
```

---

## 📂 リポジトリ構成

```text
marp-slides/
├── shared/theme.css      ← 共通テーマ
├── _template/             ← 新規スライドの雛形
├── 2026-03-xxx/slides.md  ← 各スライド
├── docs/                  ← GitHub Pages
├── scripts/new-slide.sh   ← スライド生成スクリプト
└── .github/workflows/     ← CI/CD
```

---

<!-- _class: dark -->

## まとめ

- **Marp** でスライドを Markdown 管理
- **1リポジトリ** に集約して共通テーマで統一
- **GitHub Actions** で HTML / PDF を自動ビルド
- テンプレートとスクリプトで新規作成もかんたん

---

<!-- _class: dark -->

## ありがとうございました

🔗 https://k9i-0.github.io/marp-slides/

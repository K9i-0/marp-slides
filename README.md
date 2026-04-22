# marp-slides

技術LT用の [Marp](https://marp.app/) スライドを1リポジトリで管理するテンプレートです。

- GitHub Pages で HTML 公開
- Speaker Deck 用に PDF 生成（GitHub Actions Artifacts からダウンロード）

## セットアップ

```bash
npm install
```

## 使い方

### 新規スライド作成

```bash
npm run new -- my-topic
# → 2026-03-my-topic/ が作成される
```

### プレビュー

```bash
npm run dev -- 2026-03-my-topic
```

### ビルド

```bash
# HTML（docs/ 以下に出力）
npm run build:html

# PDF（dist/ 以下に出力）
npm run build:pdf
```

### 公開

`main` ブランチにプッシュすると GitHub Actions が自動で：

1. HTML をビルドして GitHub Pages にデプロイ
2. PDF をビルドして Artifacts にアップロード

## GitHub Pages

<!-- TODO: リポジトリの Settings > Pages で GitHub Actions を選択してください -->

🔗 https://k9i-0.github.io/marp-slides/

## ディレクトリ構成

```
├── drafts/          # 人間が書く下書き・相談メモ（Markdown）
├── shared/          # 共通テーマ・アセット
├── _template/       # 新規スライドのテンプレート
├── 2026-03-xxx/     # 各スライド（日付-タイトル）
├── docs/            # GitHub Pages 公開ルート
├── scripts/         # ユーティリティスクリプト
└── .github/workflows/  # CI/CD
```

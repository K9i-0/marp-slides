#!/bin/bash
# 新規スライドのディレクトリを _template/ からコピーして作成する

set -euo pipefail

if [ $# -eq 0 ]; then
  echo "使い方: npm run new -- <スライド名>"
  echo "例: npm run new -- react-server-components"
  exit 1
fi

SLIDE_NAME="$1"
DATE_PREFIX=$(date +%Y-%m)
DIR_NAME="${DATE_PREFIX}-${SLIDE_NAME}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TARGET_DIR="${ROOT_DIR}/${DIR_NAME}"

if [ -d "$TARGET_DIR" ]; then
  echo "エラー: ${DIR_NAME} は既に存在します"
  exit 1
fi

cp -r "${ROOT_DIR}/_template" "$TARGET_DIR"
echo "✅ 作成しました: ${DIR_NAME}/"
echo "   編集: ${DIR_NAME}/slides.md"
echo "   プレビュー: npm run dev -- ${DIR_NAME}"

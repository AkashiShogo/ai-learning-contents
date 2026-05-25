#!/bin/bash
# PDF出力スクリプト
# 使い方: bash export-pdf.sh
# 出力: ./output/contents.pdf

mkdir -p ./output

# 全章を順番に結合して1つのMarkdownファイルにする
{
  cat ./00-intro/00-intro.md
  echo ""
  echo "---"
  echo ""
  cat ./01-what-is-ai/01-what-is-ai.md
  echo ""
  echo "---"
  echo ""
  cat ./02-risk/02-risk.md
  echo ""
  echo "---"
  echo ""
  cat ./03-setup/03-setup.md
  echo ""
  echo "---"
  echo ""
  cat ./04-self-learning/04-self-learning.md
  echo ""
  echo "---"
  echo ""
  cat ./05-ai-handling/05-ai-handling.md
  echo ""
  echo "---"
  echo ""
  cat ./06-vibe-coding/06-vibe-coding.md
  echo ""
  echo "---"
  echo ""
  cat ./07-todo-app/07-todo-app.md
} > ./output/contents-all.md

# PDF に変換
md-to-pdf ./output/contents-all.md --stylesheet ./pdf-style.css \
  --pdf-options '{"displayHeaderFooter": true, "headerTemplate": "<div></div>", "footerTemplate": "<div style=\"font-size: 10px; color: #aaa; text-align: center; width: 100%; padding-bottom: 4mm;\"><span class=\"pageNumber\"></span> / <span class=\"totalPages\"></span></div>", "margin": {"bottom": "20mm"}}'

echo "✓ 出力完了: ./output/contents-all.pdf"

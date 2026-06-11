#!/bin/bash
# PDF出力スクリプト
# 使い方: bash export-pdf.sh
# 出力: ./output/contents-gemini.pdf / ./output/contents-claude.pdf
# 共通章＋各トラックの章を「読む順」に結合して、トラック別のPDFを生成する

set -e

mkdir -p ./output

PDF_OPTIONS='{"displayHeaderFooter": true, "headerTemplate": "<div></div>", "footerTemplate": "<div style=\"font-size: 10px; color: #aaa; text-align: center; width: 100%; padding-bottom: 4mm;\"><span class=\"pageNumber\"></span> / <span class=\"totalPages\"></span></div>", "margin": {"bottom": "20mm"}}'

# 指定した章ファイル群を結合して1つのMarkdownにする
build_track() {
  local track="$1"
  local out="./output/contents-${track}.md"
  local files=(
    "./common/00-intro/00-intro.md"
    "./common/01-what-is-ai/01-what-is-ai.md"
    "./common/02-risk/02-risk.md"
    "./${track}/03-setup/03-setup.md"
    "./common/04-self-learning/04-self-learning.md"
    "./${track}/05-ai-handling/05-ai-handling.md"
    "./${track}/06-vibe-coding/06-vibe-coding.md"
    "./${track}/07-todo-app/07-todo-app.md"
    "./${track}/08-advanced/08-advanced.md"
  )

  : > "$out"
  local first=1
  for f in "${files[@]}"; do
    if [ "$first" -eq 0 ]; then
      { echo ""; echo "---"; echo ""; } >> "$out"
    fi
    cat "$f" >> "$out"
    first=0
  done

  md-to-pdf "$out" --stylesheet ./pdf-style.css --pdf-options "$PDF_OPTIONS"
  echo "✓ 出力完了: ./output/contents-${track}.pdf"
}

build_track gemini
build_track claude

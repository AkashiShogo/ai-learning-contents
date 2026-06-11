#!/bin/bash
# コンテンツレビュー実行スクリプト
# 使い方: bash review.sh            … 全コンテンツをレビュー
#         bash review.sh gemini     … 共通章＋Geminiトラックのみ
#         bash review.sh claude     … 共通章＋Claudeトラックのみ

TRACK="${1:-all}"

emit_common() {
  echo "=== outline.md ==="
  cat ./outline.md
  echo ""
  echo "=== 00-intro (common) ==="
  cat ./common/00-intro/00-intro.md
  echo ""
  echo "=== 第1章 (common) ==="
  cat ./common/01-what-is-ai/01-what-is-ai.md
  echo ""
  echo "=== 第2章 (common) ==="
  cat ./common/02-risk/02-risk.md
  echo ""
  echo "=== 第4章 (common) ==="
  cat ./common/04-self-learning/04-self-learning.md
  echo ""
}

emit_track() {
  local track="$1"
  for ch in 03-setup 05-ai-handling 06-vibe-coding 07-todo-app 08-advanced; do
    echo "=== ${ch} (${track}) ==="
    cat "./${track}/${ch}/${ch}.md"
    echo ""
  done
}

{
  echo "=== review-prompt.md ==="
  cat ./review-prompt.md
  echo ""
  emit_common
  case "$TRACK" in
    gemini) emit_track gemini ;;
    claude) emit_track claude ;;
    all)    emit_track gemini; emit_track claude ;;
  esac
} | gemini -p "review-prompt.md の指示に従って、すべてのコンテンツをレビューしてください。"

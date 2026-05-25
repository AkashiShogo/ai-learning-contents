#!/bin/bash
# コンテンツレビュー実行スクリプト
# 使い方: bash review.sh

{
  echo "=== review-prompt.md ==="
  cat ./review-prompt.md
  echo ""
  echo "=== outline.md ==="
  cat ./outline.md
  echo ""
  echo "=== 00-intro ==="
  cat ./00-intro/00-intro.md
  echo ""
  echo "=== 第1章 ==="
  cat ./01-what-is-ai/01-what-is-ai.md
  echo ""
  echo "=== 第2章 ==="
  cat ./02-risk/02-risk.md
  echo ""
  echo "=== 第3章 ==="
  cat ./03-setup/03-setup.md
  echo ""
  echo "=== 第4章 ==="
  cat ./04-self-learning/04-self-learning.md
  echo ""
  echo "=== 第5章 ==="
  cat ./05-ai-handling/05-ai-handling.md
  echo ""
  echo "=== 第6章 ==="
  cat ./06-vibe-coding/06-vibe-coding.md
  echo ""
  echo "=== 第7章 ==="
  cat ./07-todo-app/07-todo-app.md
} | gemini -p "review-prompt.md の指示に従って、すべてのコンテンツをレビューしてください。"

#!/bin/bash

IGNORECASE=$(git config core.ignorecase)

if [ "$IGNORECASE" = "true" ]; then
  echo "❌ core.ignorecase=true 로 되어 있어 대소문자 변경이 반영되지 않을 수 있습니다."
  echo "➡️  아래 명령을 실행하세요:"
  echo "git config core.ignorecase false"
  echo "git rm -r -cached ."
  echo "git add ."
  exit 1
fi
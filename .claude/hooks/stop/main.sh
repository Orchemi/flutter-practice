#!/bin/bash

# Stop hook 진입점
# 세션 종료 시 이 스크립트가 호출됨

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_DIR="$(dirname "$SCRIPT_DIR")"

# stdin 읽기 (hook에서 전달되는 JSON)
input=$(cat)

# 이 폴더 내 개별 스크립트 실행
"$SCRIPT_DIR/notify.sh" <<< "$input"

exit 0

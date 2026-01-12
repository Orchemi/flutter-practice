#!/bin/bash

# UserPromptSubmit hook 진입점
# 사용자가 프롬프트를 제출할 때 이 스크립트가 호출됨

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# stdin 읽기 (hook에서 전달되는 JSON)
input=$(cat)

# 이 폴더 내 개별 스크립트 실행
"$SCRIPT_DIR/save-request.sh" <<< "$input"

exit 0

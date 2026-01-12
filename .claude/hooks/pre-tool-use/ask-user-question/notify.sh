#!/bin/bash

# 사용자 입력 대기 시 Discord 알림
# summary.json 유지 (삭제 안 함)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
source "$HOOKS_DIR/common/discord.sh"

# stdin에서 JSON 입력 읽기
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd // empty')

# cwd가 없으면 현재 디렉토리 사용
if [ -z "$cwd" ]; then
  cwd="$(pwd)"
fi

# 환경변수 로드
load_env "$cwd"

# 알림 전송
send_discord_notification "$cwd" "입력 대기 중"

exit 0

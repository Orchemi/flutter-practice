#!/bin/bash

# 세션 종료 시 Discord 알림
# summary.json 삭제 포함

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
HOOKS_DIR="$(dirname "$SCRIPT_DIR")"
source "$HOOKS_DIR/common/discord.sh"

input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')

# 환경변수 로드
load_env "$cwd"

# 알림 전송
send_discord_notification "$cwd" "작업 완료"

# summary.json 삭제 (다음 세션을 위해)
delete_summary "$cwd"

exit 0

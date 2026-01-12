#!/bin/bash

# 사용자 입력을 summary.json의 request에 저장
# 시작 시간도 함께 저장하여 소요 시간 계산에 활용

input=$(cat)

cwd=$(echo "$input" | jq -r '.cwd')
prompt=$(echo "$input" | jq -r '.prompt // ""')

# 빈 입력이면 무시
if [ -z "$prompt" ]; then
  exit 0
fi

SUMMARY_FILE="$cwd/.claude/summary.json"

# 50자로 자르기 (너무 길면)
request=$(echo "$prompt" | tr '\n' ' ' | head -c 50)

# 시작 시간 (Unix timestamp)
started_at=$(date +%s)

# 기존 summary.json이 있으면 status 유지, 없으면 새로 생성
if [ -f "$SUMMARY_FILE" ]; then
  status=$(jq -r '.status // "completed"' "$SUMMARY_FILE" 2>/dev/null)
else
  status="completed"
fi

# summary.json 생성/업데이트
cat > "$SUMMARY_FILE" << EOF
{
  "status": "$status",
  "request": "$request",
  "response": "",
  "started_at": $started_at
}
EOF

exit 0

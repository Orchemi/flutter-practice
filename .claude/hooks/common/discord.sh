#!/bin/bash

# Discord 알림 공통 함수
# 사용법: source "$HOOKS_DIR/common/discord.sh"

# 환경변수 로드
load_env() {
  local env_file="$1/.env.local"
  if [ -f "$env_file" ]; then
    export $(grep -v '^#' "$env_file" | xargs)
  fi
}

# ISO 8601 형식 타임스탬프 (Discord embed용)
get_iso_timestamp() {
  date -u "+%Y-%m-%dT%H:%M:%S.000Z"
}

# 소요 시간 계산 (in 33s, in 2m 30s 형식)
calculate_duration() {
  local started_at="$1"
  local duration=""

  if [ -n "$started_at" ] && [ "$started_at" != "null" ]; then
    local ended_at=$(date +%s)
    local delta=$((ended_at - started_at))

    if [ $delta -lt 60 ]; then
      duration="in ${delta}s"
    elif [ $delta -lt 3600 ]; then
      local minutes=$((delta / 60))
      local seconds=$((delta % 60))
      if [ $seconds -eq 0 ]; then
        duration="in ${minutes}m"
      else
        duration="in ${minutes}m ${seconds}s"
      fi
    else
      local hours=$((delta / 3600))
      local minutes=$(((delta % 3600) / 60))
      if [ $minutes -eq 0 ]; then
        duration="in ${hours}h"
      else
        duration="in ${hours}h ${minutes}m"
      fi
    fi
  fi

  echo "$duration"
}

# summary.json 읽기
read_summary() {
  local summary_file="$1"

  if [ -f "$summary_file" ]; then
    SUMMARY_REQUEST=$(jq -r '.request // ""' "$summary_file" 2>/dev/null)
    SUMMARY_RESPONSE=$(jq -r '.response // ""' "$summary_file" 2>/dev/null)
    SUMMARY_STARTED_AT=$(jq -r '.started_at // ""' "$summary_file" 2>/dev/null)
  else
    SUMMARY_REQUEST=""
    SUMMARY_RESPONSE=""
    SUMMARY_STARTED_AT=""
  fi
}

# Discord 메시지 전송
# 인자: $1=cwd, $2=status_text ("작업 완료" 또는 "입력 대기 중")
send_discord_notification() {
  local cwd="$1"
  local status_text="$2"

  local webhook="${PERSONAL_DISCORD_WEBHOOK_URL}"
  if [ -z "$webhook" ]; then
    return 0
  fi

  local app_name=$(basename "$cwd")
  local timestamp=$(get_iso_timestamp)
  local summary_file="$cwd/.claude/summary.json"

  # summary.json 읽기
  read_summary "$summary_file"

  # 소요 시간 계산
  local duration=$(calculate_duration "$SUMMARY_STARTED_AT")

  # 상태에 따른 색상 설정 (Discord embed color는 10진수)
  local color
  if [ "$status_text" = "작업 완료" ]; then
    color=3066993  # 녹색 (#2ECC71)
  else
    color=15844367  # 노란색 (#F1C40F)
  fi

  # 타이틀 구성
  local title
  if [ -n "$duration" ]; then
    title="$app_name $status_text \`$duration\`"
  else
    title="$app_name $status_text"
  fi

  # footer 구성
  local footer_icon="https://storage.googleapis.com/cms-storage-bucket/4fd0db61df0567c0f352.png"
  local footer_text="flutter-practice"

  # fields 구성 (emoji + 항목명, inline: false)
  local fields="["
  local has_field=false

  if [ -n "$SUMMARY_REQUEST" ]; then
    fields="$fields{\"name\": \":speech_balloon: 요청\", \"value\": \"$SUMMARY_REQUEST\", \"inline\": false}"
    has_field=true
  fi

  if [ -n "$SUMMARY_RESPONSE" ]; then
    if [ "$has_field" = true ]; then
      fields="$fields, "
    fi
    fields="$fields{\"name\": \":white_check_mark: 응답\", \"value\": \"$SUMMARY_RESPONSE\", \"inline\": false}"
  fi

  fields="$fields]"

  # Discord 전송
  curl -s -X POST -H 'Content-type: application/json' \
    --data "{
      \"username\": \"Claude Code\",
      \"avatar_url\": \"https://uxwing.com/wp-content/themes/uxwing/download/brands-and-social-media/claude-ai-icon.png\",
      \"embeds\": [
        {
          \"title\": \"$title\",
          \"color\": $color,
          \"fields\": $fields,
          \"footer\": {
            \"text\": \"$footer_text\",
            \"icon_url\": \"$footer_icon\"
          },
          \"timestamp\": \"$timestamp\"
        }
      ]
    }" "$webhook" > /dev/null
}

# summary.json 삭제
delete_summary() {
  local summary_file="$1/.claude/summary.json"
  if [ -f "$summary_file" ]; then
    rm -f "$summary_file"
  fi
}

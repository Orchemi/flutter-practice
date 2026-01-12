# Discord 작업 완료 알림 워크플로우

Claude Code 세션 종료 시 Discord로 작업 요약 알림을 자동 전송하는 시스템입니다.

## 동작 흐름

```
┌─────────────────────────────────────────────────────────────────┐
│                     사용자 입력 (UserPromptSubmit)                │
├─────────────────────────────────────────────────────────────────┤
│  settings.json의 UserPromptSubmit hook 트리거                    │
│  → bash .claude/hooks/user-prompt-submit/main.sh 실행           │
│  → main.sh가 save-request.sh 호출                               │
│  → summary.json에 request + started_at(시작시간) 저장            │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                        Claude 세션 중                            │
├─────────────────────────────────────────────────────────────────┤
│  1. 사용자 요청 처리                                              │
│  2. 응답 직전 → summary.json의 request/response 요약 업데이트       │
│     {                                                           │
│       "status": "completed" 또는 "question",                    │
│       "request": "요청 요약 (Claude가 요약)",                     │
│       "response": "작업 결과 (Claude가 요약)"                     │
│     }                                                           │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                      세션 종료 (Stop)                            │
├─────────────────────────────────────────────────────────────────┤
│  settings.json의 Stop hook 트리거                                │
│  → bash .claude/hooks/stop/main.sh 실행                         │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                  stop/main.sh 실행                               │
├─────────────────────────────────────────────────────────────────┤
│  1. stop/notify.sh 호출                                         │
│  2. common/discord.sh 로드 (공통 함수)                           │
│  3. .env.local에서 PERSONAL_DISCORD_WEBHOOK_URL 로드             │
│  4. summary.json 읽기 + 소요 시간 계산                            │
│  5. "작업 완료" 메시지 구성 후 Discord로 POST                      │
│  6. summary.json 삭제 (다음 세션을 위해)                          │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│                     Discord 알림 수신                            │
├─────────────────────────────────────────────────────────────────┤
│  flutter-practice 작업 완료 `in 2m 30s`                          │
│  **요청** {request}                                             │
│  **응답** {response}                                             │
│  **일시** 26.01.07.(수) 11:31                                    │
└─────────────────────────────────────────────────────────────────┘
```

## 디렉토리 구조

```
.claude/hooks/
├── common/
│   └── discord.sh                  # 알림 공통 함수
├── stop/
│   ├── main.sh                     # Stop hook 진입점
│   └── notify.sh                   # 알림 스크립트
├── pre-tool-use/
│   └── ask-user-question/
│       ├── main.sh                 # PreToolUse hook 진입점
│       └── notify.sh               # 입력 대기 알림
└── user-prompt-submit/
    ├── main.sh                     # UserPromptSubmit hook 진입점
    └── save-request.sh             # 요청 저장
```

## 관련 파일

| 파일 | 역할 |
|------|------|
| `.claude/settings.json` | hooks 등록 (UserPromptSubmit, PreToolUse, Stop) |
| `.claude/hooks/common/discord.sh` | 알림 공통 함수 (환경변수, 메시지 구성, 전송) |
| `.claude/hooks/stop/main.sh` | Stop hook 진입점 |
| `.claude/hooks/stop/notify.sh` | 세션 종료 시 알림 |
| `.claude/hooks/pre-tool-use/ask-user-question/main.sh` | PreToolUse hook 진입점 |
| `.claude/hooks/pre-tool-use/ask-user-question/notify.sh` | 입력 대기 시 알림 |
| `.claude/hooks/user-prompt-submit/main.sh` | UserPromptSubmit hook 진입점 |
| `.claude/hooks/user-prompt-submit/save-request.sh` | 사용자 입력 시 request 저장 |
| `.claude/summary.json` | 요약 파일 (임시, 전송 후 삭제) |
| `.env.local` | 환경변수 (PERSONAL_DISCORD_WEBHOOK_URL) |

## 환경변수

`.env.local`에 설정:

```bash
# 필수 - Discord Webhook URL (개인 알림용)
PERSONAL_DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/xxx/xxx
```

## Claude 필수 규칙

> **이 규칙은 예외 없이 반드시 지켜야 합니다.**

### 응답 직전 summary.json 업데이트

**Edit 도구**로 `request`와 `response` 필드 수정:

```bash
# 올바른 방법 (Edit 사용)
Edit: "request": "원본 메시지..." → "request": "요청 요약"
Edit: "response": "" → "response": "수행 결과 요약"
```

```bash
# 잘못된 방법 (Write로 덮어쓰기 금지!)
Write: 전체 파일 덮어쓰기 → started_at 사라짐 → 소요시간 계산 불가
```

### 필드별 역할

| 필드 | 담당 | 설명 |
|------|------|------|
| `request` | **Claude** | 응답 직전 Edit으로 요약 업데이트 |
| `started_at` | hook 자동 | 소요시간 계산용 (건드리지 말 것) |
| `response` | **Claude** | 응답 직전 Edit으로 요약 업데이트 |
| `status` | Claude | `completed` 또는 `question` |

### 요약 작성 규칙

- **한국어**, **명사형**으로 작성
- **50자 이내**로 핵심만
- 특수문자, 줄바꿈 없이 간결하게

### 왜 즉시 업데이트해야 하는가?

- 사용자가 언제 세션을 종료할지 알 수 없음
- Stop hook 실행 시점에는 Claude가 이미 종료된 상태
- summary.json이 없으면 알림에 요청/응답이 누락됨

## 입력 대기 알림

Claude가 `AskUserQuestion` 도구를 호출하면 `PreToolUse` hook이 자동으로 트리거되어 알림을 전송합니다.

**동작 방식:**
- `AskUserQuestion` 호출 직전에 `main.sh → notify.sh` 순서로 실행
- "입력 대기 중" 알림 전송
- summary.json 유지 (삭제 안 함)
- 사용자가 질문에 응답할 때까지 알림으로 알 수 있음

## 확장 방법

새로운 hook 스크립트를 추가하려면:

1. 해당 hook 폴더에 새 스크립트 추가 (예: `stop/cleanup.sh`)
2. `main.sh`에서 새 스크립트 호출 추가

```bash
# stop/main.sh
"$SCRIPT_DIR/notify.sh" <<< "$input"
"$SCRIPT_DIR/cleanup.sh" <<< "$input"  # 새로 추가
```

## 알림이 안 올 때 체크리스트

1. `.env.local`에 `PERSONAL_DISCORD_WEBHOOK_URL` 있는지 확인
2. `.claude/settings.json`에 Stop hook 설정 있는지 확인
3. `.claude/hooks/stop/main.sh` 파일 존재하는지 확인
4. Claude가 summary.json을 생성했는지 확인 (요청/응답 누락 시)

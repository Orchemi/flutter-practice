# 커밋 명령어

**⚠️ 필수**: 실행 전 반드시 `.claude/skills/git-workflow/references/commit-guide.md`를 읽고 절차를 정확히 따르세요.

`.claude/skills/git-workflow/SKILL.md`의 **커밋 절차**를 실행합니다.

## Auto 모드

- **기본 (`/commit`)**: AskUserQuestion으로 타입/메시지 확인 후 커밋
- **`/commit auto`**: 질문 없이 자동으로 타입/메시지 결정 후 바로 커밋

**주의**: `/commit auto` 시 Step 3의 AskUserQuestion을 생략하고 변경 내용 분석 결과를 기반으로 최적의 타입과 메시지를 자동 결정합니다.

---

**입력된 인자**: $ARGUMENTS

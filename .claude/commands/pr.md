# PR 명령어

**⚠️ 필수**: 실행 전 반드시 `.claude/skills/git-workflow/references/pr-guide.md`를 읽고 절차를 정확히 따르세요.

**⚠️ 중요**: PR body 작성 시 heredoc을 사용할 때:

- `cat <<'EOF'`처럼 single quote로 감싸서 변수 확장 방지
- backtick(`)은 escape하지 말고 그대로 사용 (예: ` ``` ` 코드 블록)
- escape 문자(`\`)를 잘못 사용하면 GitHub에서 형식이 깨짐

`.claude/skills/git-workflow/SKILL.md`의 **PR 절차**를 실행합니다.

## Target Branch 규칙

- **기본**: `main` (질문 없이 바로 진행)
- **`/pr hotfix`**: `hotfix` 브랜치를 target으로 사용

**주의**: Step 0의 AskUserQuestion을 생략하고 위 규칙에 따라 target branch를 결정합니다.

---

**입력된 인자**: $ARGUMENTS

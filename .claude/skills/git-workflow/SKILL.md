---
name: git-workflow
description: Git 커밋, PR, push 작업을 프로젝트 컨벤션에 맞게 처리합니다.
trigger: 커밋, commit, PR, push, 푸시
activate_when: 사용자가 명시적으로 커밋, PR, push를 요청할 때만 (작업 완료 후 자동 발동 금지)
---

# Git Workflow Skill

## 핵심 규칙

### Push 전 승인 필수
푸시 전 반드시 사용자 승인 필요. 푸시할 커밋 목록을 보여주고 명시적 허락을 받은 후 실행.

### 상세 가이드

요청에 따라 아래 타입별 가이드를 반드시 참조하세요.

- **커밋 절차**: [commit-guide.md](references/commit-guide.md)
- **PR 절차**: [pr-guide.md](references/pr-guide.md)


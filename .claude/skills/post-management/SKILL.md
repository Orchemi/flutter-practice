---
name: post-management
description: 블로그 포스트 작성, 검사, 수정을 지원합니다.
trigger: 포스트, 글, MDX, 블로그, 맞춤법, 검사, 새 글
activate_when: 블로그 포스트 생성, 검사, 수정 요청 시
---

# Post Management Skill

## MDX 파일 위치

- 포스트: `posts/<category>/<subcategory>/<filename>.mdx`
- 작업 대상: changed files 또는 현재 열린 파일에서 확인

## Frontmatter

[frontmatter-guide.md](references/frontmatter-guide.md) 참조

## 상세 가이드

요청에 따라 해당 가이드를 참조하세요:

- **새 포스트 생성**: [new-post-guide.md](references/new-post-guide.md)
- **포스트 품질 검사**: [check-post-guide.md](references/check-post-guide.md)

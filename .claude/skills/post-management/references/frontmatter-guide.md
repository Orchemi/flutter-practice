# Frontmatter 가이드

## 필수 필드

| 필드        | 설명        | 형식                |
| ----------- | ----------- | ------------------- |
| title       | 포스트 제목 | 문자열              |
| description | 포스트 설명 | 문자열              |
| categories  | 카테고리    | YAML block sequence |
| tags        | 태그        | YAML block sequence |
| createdAt   | 작성 날짜   | YYYY-MM-DDTHH:mm    |

## 템플릿

```yaml
---
title: ""
description: ""

categories:
  - <카테고리>

tags:
  - <태그1>
  - <태그2>

createdAt: <YYYY-MM-DDTHH:mm>
published: false
---
```

## 주의사항

- `published: false` — 새 포스트 생성 시 필수 포함
- `tags` — inline array(`[tag1, tag2]`) 금지, 반드시 `-`로 개별 나열

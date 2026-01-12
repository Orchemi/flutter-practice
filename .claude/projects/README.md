# Claude Code 프로젝트 관리

이 디렉토리는 Claude Code를 활용한 대규모 작업 프로젝트들을 관리합니다.

## 프로젝트 목록

| 프로젝트 | 설명 | 상태 | 기간 |
| -------- | ---- | ---- | ---- |
| [flutter-initial-setup](./flutter-initial-setup/ROADMAP.md) | Flutter 프로젝트 초기 설정 | 🔲 진행 전 | 2025-01 |
<!-- 새 프로젝트 추가 시 여기에 행 추가 -->

<!--
새 프로젝트 추가 시 위 테이블에 행 추가
상태: 🔲 진행 전 | 🔄 진행 중 | ✅ 완료 | ⏸️ 보류
-->

## 새 프로젝트 시작하기

### 1. 템플릿 복사

```bash
cp -r .claude/projects/_templates/project-template .claude/projects/my-new-project
```

### 2. 파일 수정

- `ROADMAP.md`: 프로젝트 개요 및 목표 작성
- `plans/`: 세부 실행 계획 작성
- `docs/`: 보조 문서 작성

### 3. 목록 업데이트

이 파일(`README.md`)의 프로젝트 목록에 새 프로젝트 추가

## 디렉토리 구조

```
projects/
├── README.md              # 이 파일 (프로젝트 인덱스)
├── _templates/            # 프로젝트 템플릿
│   └── project-template/
│       ├── ROADMAP.md
│       ├── plans/
│       └── docs/
│
└── {project-name}/        # 개별 프로젝트
    ├── ROADMAP.md         # 전체 로드맵 (진입점)
    ├── plans/             # 세부 계획
    │   ├── 01-phase1.md
    │   └── ...
    └── docs/              # 관련 문서
        └── non-tech-summary.md
```

## 네이밍 규칙

### 프로젝트명

- 형식: `{주제}-{목적}` (kebab-case)
- 예시: `code-quality-improvement`, `homepage-redesign`, `admin-v2-migration`

### 태스크 ID

- 형식: `TASK-{월}{순번}` 또는 `TASK-{순번}`
- 예시: `TASK-0101` (1월 1번 태스크), `TASK-001`

## Claude Code 사용법

### 프로젝트 참조

```
@code-quality-improvement/ROADMAP.md 를 참고해서 현재 진행 상황을 알려줘
```

### 태스크 실행

```
@code-quality-improvement/plans/01-config-fixes.md 의 TASK-001을 진행해줘
```

### 상태 업데이트

```
@code-quality-improvement/plans/01-config-fixes.md 의 TASK-001 체크박스를 업데이트해줘
```

## 상태 아이콘

| 아이콘 | 의미    |
| ------ | ------- |
| 🔲     | 진행 전 |
| 🔄     | 진행 중 |
| ✅     | 완료    |
| ⏸️     | 보류    |
| ❌     | 취소    |

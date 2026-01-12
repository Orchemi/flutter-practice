# Phase 2: 프로젝트 구조

## 목표

> Clean Architecture 기반의 확장 가능한 폴더 구조를 만들고, 필수 패키지를 설치합니다.

## React와 비교

| React/Next.js | Flutter | 역할 |
|---------------|---------|------|
| `src/components/` | `lib/shared/widgets/` | 공통 UI 컴포넌트 |
| `src/pages/` | `lib/features/*/presentation/screens/` | 화면 |
| `src/hooks/` | `lib/features/*/presentation/providers/` | 상태/로직 |
| `src/api/` | `lib/features/*/data/` | 데이터 레이어 |
| `src/types/` | `lib/features/*/domain/models/` | 타입/모델 |
| `package.json` | `pubspec.yaml` | 의존성 |
| `.eslintrc` | `analysis_options.yaml` | lint 설정 |

## 태스크 요약

| ID | 태스크 | 상태 |
|----|--------|------|
| TASK-0201 | 폴더 구조 생성 | 🔲 |
| TASK-0202 | 필수 패키지 설치 (pubspec.yaml) | 🔲 |
| TASK-0203 | analysis_options.yaml 설정 | 🔲 |

---

## TASK-0201: 폴더 구조 생성

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | 🔲 진행 전 |
| **선행 조건** | Phase 1 완료 |

### 왜 이 구조인가?

**Feature-First + Clean Architecture**를 사용합니다:

1. **Feature-First**: 기능별로 코드를 그룹화
   - React의 `src/features/` 패턴과 동일
   - 기능 추가/삭제가 쉬움

2. **Clean Architecture**: 각 기능 내에서 레이어 분리
   - `presentation`: UI (화면, 위젯)
   - `domain`: 비즈니스 로직 (모델)
   - `data`: 데이터 소스 (API, DB)

### 체크리스트

#### 1단계: core 폴더 생성

```
lib/core/
├── constants/       # 색상, 크기, 문자열 상수
├── theme/           # 테마 설정
├── router/          # 라우팅 설정
├── utils/           # 유틸리티 함수
├── extensions/      # Dart 확장 메서드
└── network/         # HTTP 클라이언트 (dio) 설정
```

- [ ] `lib/core/constants/` 생성
- [ ] `lib/core/theme/` 생성
- [ ] `lib/core/router/` 생성
- [ ] `lib/core/utils/` 생성
- [ ] `lib/core/extensions/` 생성
- [ ] `lib/core/network/` 생성

#### 2단계: features 폴더 생성 (home 예시)

```
lib/features/home/
├── presentation/
│   ├── screens/     # 화면 위젯
│   ├── widgets/     # 기능 전용 위젯
│   └── providers/   # Riverpod providers
├── domain/
│   └── models/      # 데이터 모델 (freezed)
└── data/
    ├── repositories/  # 저장소 패턴
    └── datasources/   # API, 로컬 DB
```

- [ ] `lib/features/home/presentation/screens/` 생성
- [ ] `lib/features/home/presentation/widgets/` 생성
- [ ] `lib/features/home/presentation/providers/` 생성
- [ ] `lib/features/home/domain/models/` 생성
- [ ] `lib/features/home/data/repositories/` 생성
- [ ] `lib/features/home/data/datasources/` 생성

#### 3단계: shared 폴더 생성

```
lib/shared/
├── widgets/         # 공통 위젯 (버튼, 카드 등)
├── providers/       # 공통 providers
└── models/          # 공통 모델
```

- [ ] `lib/shared/widgets/` 생성
- [ ] `lib/shared/providers/` 생성
- [ ] `lib/shared/models/` 생성

#### 4단계: .gitkeep 또는 placeholder 파일 생성

Dart는 빈 폴더를 유지하지 않으므로, 각 폴더에 파일 생성

### Claude Code 지침

```markdown
TASK-0201을 진행해줘.
위 구조대로 폴더를 생성하고, 각 폴더에 .gitkeep 파일을 생성해줘.
```

### 완료 기준

- [ ] 모든 폴더 생성됨
- [ ] 각 폴더에 .gitkeep 존재

### 사용자 검수 포인트

1. `lib/` 하위 구조가 계획대로 생성되었는지 확인
2. `core/`, `features/`, `shared/` 3개 주요 폴더 확인

---

## TASK-0202: 필수 패키지 설치 (pubspec.yaml)

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | 🔲 진행 전 |
| **선행 조건** | TASK-0201 완료 |

### 왜 이 패키지들인가?

| 패키지 | React 대응 | 역할 |
|--------|-----------|------|
| `go_router` | React Router | 라우팅 |
| `flutter_riverpod` | Redux/Zustand | 상태 관리 |
| `riverpod_annotation` | - | Riverpod 코드 생성 |
| `dio` | axios | HTTP 클라이언트 |
| `shared_preferences` | localStorage | 로컬 저장소 |
| `flutter_hooks` | React Hooks | Hooks 패턴 |
| `hooks_riverpod` | - | Hooks + Riverpod 통합 |
| `freezed` | TypeScript interface | 불변 데이터 클래스 |
| `json_serializable` | - | JSON 직렬화 |
| `build_runner` | - | 코드 생성 실행기 |

### 체크리스트

#### 1단계: pubspec.yaml 수정

```yaml
name: flutter_practice
description: Flutter 연습용 프로젝트
publish_to: 'none'
version: 1.0.0+1

environment:
  sdk: ^3.5.0

dependencies:
  flutter:
    sdk: flutter

  # 기본 UI
  cupertino_icons: ^1.0.8

  # 라우팅
  go_router: ^14.6.2

  # 상태 관리
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.6.1

  # HTTP 클라이언트
  dio: ^5.7.0

  # 로컬 저장소
  shared_preferences: ^2.3.3

  # Hooks 패턴
  flutter_hooks: ^0.20.5
  hooks_riverpod: ^2.6.1

  # 불변 데이터 클래스 (런타임)
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0

dev_dependencies:
  flutter_test:
    sdk: flutter

  # 린트
  flutter_lints: ^5.0.0

  # 코드 생성
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.2
  freezed: ^2.5.7
  json_serializable: ^6.8.0

flutter:
  uses-material-design: true
```

#### 2단계: 패키지 설치

```bash
flutter pub get
```

### Claude Code 지침

```markdown
TASK-0202를 진행해줘.
pubspec.yaml을 위 내용으로 수정하고 flutter pub get을 실행해줘.
```

### 완료 기준

- [ ] `pubspec.yaml` 수정 완료
- [ ] `flutter pub get` 성공
- [ ] `pubspec.lock` 업데이트됨

### 사용자 검수 포인트

1. pubspec.yaml에 모든 패키지가 있는지 확인
2. 에러 없이 설치되었는지 확인

---

## TASK-0203: analysis_options.yaml 설정

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | 🔲 진행 전 |
| **선행 조건** | TASK-0202 완료 |

### 왜 필요한가?

ESLint처럼 코드 품질을 강제합니다. 엄격한 규칙으로 설정하면:
- 타입 에러 조기 발견
- 일관된 코드 스타일
- 사용하지 않는 코드 감지

### 체크리스트

#### 1단계: analysis_options.yaml 수정

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  errors:
    # 사용하지 않는 import → 에러
    unused_import: error
    # 사용하지 않는 지역 변수 → 경고
    unused_local_variable: warning
    # 사용하지 않는 필드 → 경고
    unused_field: warning

  exclude:
    # 생성된 파일 제외 (freezed, riverpod 등)
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.gr.dart"
    - "**/generated/**"

  language:
    # strict 모드 활성화
    strict-casts: true
    strict-inference: true
    strict-raw-types: true

linter:
  rules:
    # === 필수 규칙 ===
    # const 사용 권장
    prefer_const_constructors: true
    prefer_const_declarations: true
    prefer_const_literals_to_create_immutables: true

    # 타입 명시
    always_declare_return_types: true
    always_specify_types: false  # 추론 가능할 때는 생략 허용

    # print 사용 금지 (릴리즈에서 문제)
    avoid_print: true

    # === 코드 스타일 ===
    # 줄 끝 공백 금지
    avoid_trailing_whitespace: true
    # 빈 else 금지
    avoid_empty_else: true
    # 불필요한 this 금지
    unnecessary_this: true
    # 불필요한 new 금지
    unnecessary_new: true

    # === 가독성 ===
    # 한 줄에 하나의 선언
    avoid_multiple_declarations_per_line: true
    # 빈 생성자 본문 금지
    empty_constructor_bodies: true

    # === Riverpod 관련 ===
    # Provider를 외부에서 변경하지 않도록
    # (riverpod_lint 추가 시 더 많은 규칙 적용 가능)
```

#### 2단계: 검증

```bash
flutter analyze
```

### Claude Code 지침

```markdown
TASK-0203을 진행해줘.
analysis_options.yaml을 위 내용으로 수정하고 flutter analyze를 실행해줘.
```

### 완료 기준

- [ ] `analysis_options.yaml` 수정 완료
- [ ] `flutter analyze` 에러 없음 (또는 기존 코드 에러만 있음)

### 사용자 검수 포인트

1. analysis_options.yaml 내용 확인
2. flutter analyze 결과 확인

---

## 진행 현황

```
Phase 2 진행률: [░░░░░░░░░░] 0%

TASK-0201 (폴더 구조):     [░░░░░░░░░░] 0%
TASK-0202 (패키지 설치):   [░░░░░░░░░░] 0%
TASK-0203 (lint 설정):     [░░░░░░░░░░] 0%
```

## 다음 단계

Phase 2 완료 후 → [Phase 3: 코드 생성 도구](./03-code-generation.md)로 이동

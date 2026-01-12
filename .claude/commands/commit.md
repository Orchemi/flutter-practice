# 커밋 명령어

프로젝트의 커밋 컨벤션에 맞춰 커밋을 생성합니다.

## 커밋 메시지 형식

```
<Type>: <Subject> #<이슈번호>
```

### Type 종류

| Type     | 설명                              |
| -------- | --------------------------------- |
| feat     | 새로운 기능 추가                  |
| fix      | 버그 수정                         |
| style    | 스타일 수정 (코드 로직 변경 없음) |
| refactor | 코드 리팩토링                     |
| docs     | 문서 수정                         |
| chore    | 기타 작업 (빌드, 설정 등)         |

## 실행 순서

### Step 1: 현재 상태 확인

```bash
git status
git diff --staged
git diff
```

### Step 2: 브랜치에서 이슈 번호 추출

```bash
git branch --show-current
```

- 브랜치 이름 형식: `feat/123`, `fix/456` 등
- 숫자 부분을 이슈 번호로 사용

### Step 3: 변경 사항 분석 및 커밋 메시지 작성

**staged 변경사항이 있는 경우:**

```bash
git diff --staged
```

- staged된 파일들의 변경 내용만 분석
- staged 내용만 기반으로 커밋 메시지 작성
- unstaged 변경사항은 커밋 메시지에 포함하지 않음

**staged 변경사항이 없는 경우:**

```bash
git diff
git status
```

- 모든 변경 파일(untracked + modified)의 내용을 분석
- 전체 변경사항을 요약하여 커밋 메시지 작성
- 커밋 전 `git add -A`로 전체 스테이징

### Step 4: 커밋 타입 및 메시지 제안

AskUserQuestion 도구로 사용자에게 확인:

1. **커밋 타입 선택** (분석 결과 기반 추천)
2. **커밋 메시지 확인/수정**

### Step 5: 커밋 실행

```bash
# staged 변경사항이 없었던 경우에만 전체 추가
git add -A

# 커밋 생성
git commit -m "<Type>: <Subject> #<이슈번호>"
```

**주의**: staged 변경사항이 있었던 경우 `git add`를 실행하지 않고 바로 커밋

## 규칙

1. Subject는 명령형으로 작성 (예: "추가", "수정", "개선")
2. Subject 끝에 마침표 없음
3. Subject는 50자 이내로 간결하게
4. 이슈 번호는 브랜치에서 자동 추출
5. 한글 커밋 메시지 사용

## 예시

```
Feat: 다크모드 토글 버튼 추가 #112
Fix: 사이드바 스크롤 오류 해결 #108
Style: 헤더 레이아웃 간격 조정 #115
Refactor: API 호출 로직 분리 #120
Docs: README 설치 가이드 업데이트 #99
Chore: ESLint 설정 업데이트 #101
```

$ARGUMENTS

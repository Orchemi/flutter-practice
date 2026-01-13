# Git Branch Sync 명령어

PR merge 후 target branch를 fetch하여 현재 branch에 merge합니다.

---

## 개요

PR을 merge한 후, target branch의 최신 변경사항을 현재 branch에 반영하는 과정을 자동화합니다.

**기본 워크플로우**:
1. PR이 merge되었는지 확인
2. Target branch를 local에 fetch
3. 충돌 여부 확인
4. 문제 없으면 현재 branch에 merge

---

## 실행 순서

### Step 0: 현재 상태 확인

```bash
git status
git branch --show-current
```

커밋되지 않은 변경사항이 있으면 중단하고 사용자에게 알림.

### Step 1: Target Branch 선택

**AskUserQuestion 도구를 사용하여 target branch를 질문합니다:**

- 질문: "어떤 branch를 가져올까요?"
- 옵션:
  - `main` (기본, 권장)
  - `develop`
  - 사용자가 "Other"를 선택하면 직접 branch 이름 입력

선택된 branch를 `<target-branch>`로 사용합니다.

### Step 2: PR Merge 확인

현재 branch의 PR이 merge되었는지 확인:

```bash
gh pr list --head $(git branch --show-current) --state merged --json number,title,url
```

**결과에 따른 분기**:

- **Merged PR이 있는 경우**: 계속 진행
- **Merged PR이 없는 경우**:
  - AskUserQuestion으로 확인: "PR이 merge되지 않았습니다. 계속 진행하시겠습니까?"
  - 사용자가 "아니오"를 선택하면 중단

### Step 3: Target Branch Fetch

local의 target branch를 remote와 동기화:

```bash
git fetch origin <target-branch>:<target-branch>
```

**에러 처리 (중요!)**:

이 명령어는 다음과 같은 경우 실패할 수 있습니다:

1. **Local branch가 remote보다 앞서 있는 경우**:
   - 에러 메시지: `! [rejected] ... (non-fast-forward)`
   - **대응**: 사용자에게 상황 설명 후 중단
   - 메시지: "Local <target-branch>가 remote보다 앞서 있습니다. 수동으로 확인이 필요합니다."

2. **Local에 target branch가 없는 경우**:
   - 자동으로 생성되므로 문제없음

3. **Network 오류**:
   - 에러 메시지 그대로 표시 후 중단

**에러 발생 시**:
- 더 이상 진행하지 않음
- git merge 실행하지 않음
- 사용자에게 에러 내용 전달

### Step 4: Merge 가능 여부 확인

실제 merge 전에 충돌 여부를 미리 확인:

```bash
git merge --no-commit --no-ff <target-branch>
```

**결과에 따른 분기**:

- **충돌 없음**:
  - `git merge --abort`로 되돌린 후 Step 5로 진행

- **충돌 있음**:
  - `git merge --abort`로 되돌림
  - 사용자에게 알림: "Merge 시 충돌이 예상됩니다. 수동으로 merge를 진행해야 합니다."
  - AskUserQuestion: "충돌이 있어도 merge를 진행하시겠습니까?"
    - "예" 선택 시: Step 5로 진행
    - "아니오" 선택 시: 중단

### Step 5: Merge 실행

```bash
git merge <target-branch>
```

**결과 표시**:

- Merge 성공 시:
  ```
  ✅ <target-branch>를 현재 branch에 merge했습니다.
  Fast-forward merge: <commit-hash>
  ```

- Merge 실패 (충돌) 시:
  ```
  ⚠️ Merge 충돌이 발생했습니다.
  충돌 파일:
  - file1.dart
  - file2.dart

  다음 명령어로 충돌을 해결하세요:
  1. 충돌 파일 수정
  2. git add <파일>
  3. git commit
  ```

### Step 6: 결과 요약

```bash
git log --oneline -5
```

최근 5개 커밋을 보여주고 종료.

---

## 사용 예시

### 예시 1: 정상 케이스

```
사용자: /git-branch-sync

1. ✅ 현재 branch: feat/7
2. 🔀 Target branch: main 선택
3. ✅ PR #8이 merge되었습니다
4. ✅ origin/main을 local main에 fetch했습니다
5. ✅ 충돌 없음 확인
6. ✅ main을 feat/7에 merge했습니다 (Fast-forward)

최근 커밋:
- abc1234 Feat: Phase 4 완료
- def5678 Feat: Phase 3 완료
- ...
```

### 예시 2: Local main이 remote보다 앞선 경우

```
사용자: /git-branch-sync

1. ✅ 현재 branch: feat/7
2. 🔀 Target branch: main 선택
3. ✅ PR #8이 merge되었습니다
4. ❌ Fetch 실패: Local main이 remote보다 앞서 있습니다.

⚠️ 상황 설명:
Local main branch가 remote origin/main보다 커밋이 앞서 있어
자동으로 fetch할 수 없습니다.

다음 중 하나를 선택하세요:
1. Local main을 reset: git checkout main && git reset --hard origin/main
2. 수동으로 확인: git checkout main && git log origin/main..main

작업이 중단되었습니다.
```

### 예시 3: Merge 충돌 발생

```
사용자: /git-branch-sync

1. ✅ 현재 branch: feat/7
2. 🔀 Target branch: main 선택
3. ✅ PR #8이 merge되었습니다
4. ✅ origin/main을 local main에 fetch했습니다
5. ⚠️ Merge 충돌이 예상됩니다

충돌 예상 파일:
- lib/main.dart
- pubspec.yaml

진행하시겠습니까? (예/아니오)

[사용자가 "예" 선택]

6. ⚠️ Merge 충돌이 발생했습니다

충돌 파일:
- lib/main.dart

다음 명령어로 충돌을 해결하세요:
1. 충돌 파일 수정
2. git add lib/main.dart
3. git commit
```

---

## 주의사항

1. **커밋되지 않은 변경사항**:
   - 작업 중인 변경사항이 있으면 먼저 커밋하거나 stash 필요
   - 이 명령어는 자동으로 stash하지 않음

2. **Local target branch 상태**:
   - Local main이 remote보다 앞서 있으면 fetch 실패
   - 이 경우 수동으로 확인 필요

3. **Merge 전략**:
   - 기본적으로 merge commit 생성 (`--no-ff`)
   - Fast-forward 가능한 경우에도 merge commit 생성

4. **PR Merge 확인**:
   - PR이 merge되지 않았어도 진행 가능
   - 단, 권장하지 않음 (main에 변경사항이 반영 안 됨)

---

## 규칙

1. **에러 발생 시 중단**: fetch나 merge에서 에러 발생 시 즉시 중단
2. **사용자 확인**: 충돌이 예상되면 사용자에게 확인
3. **정보 제공**: 각 단계마다 진행 상황을 명확히 표시
4. **안전 우선**: 문제가 있으면 자동으로 진행하지 않음

---

## 별칭

- `/git-branch-sync`: 이 명령어 실행
- target branch 기본값: `main`

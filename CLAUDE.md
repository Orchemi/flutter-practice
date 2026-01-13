# CLAUDE.md

이 파일은 Claude Code가 이 저장소에서 작업할 때 참고하는 가이드입니다.

---

## 최우선 규칙

### Git 커밋/PR/Push

커밋/PR 요청 시 반드시 해당 command 파일 절차를 따를 것:
- **커밋**: `.claude/commands/commit.md`
- **PR**: `.claude/commands/pr.md`

**Push 규칙**: 푸시 전 반드시 사용자 승인 필요. 푸시할 커밋 목록을 보여주고 명시적 허락을 받은 후 실행.

**핵심**: 변경사항 보여주기 → 명시적 승인 → 실행

### 작업 완료 알림 (매 응답 종료 직전 필수)

**모든 응답의 마지막 행동으로** `.claude/summary.json` 파일을 Edit 도구로 수정할 것.

| 필드 | 작성 방법 |
|------|-----------|
| `request` | 사용자가 요청한 내용을 한글 한 문장으로 요약 |
| `response` | 내가 수행한 작업 결과를 한글 한 문장으로 요약 |
| `started_at` | **절대 수정 금지** (hook이 자동 생성) |

**기본 예시:**
```json
{
  "request": "Flutter 프로젝트 초기 설정 요청",
  "response": "pubspec.yaml 및 기본 구조 생성 완료",
  "started_at": "..."
}
```

**커밋 완료 시 예시:**
```json
{
  "request": "커밋 요청",
  "response": "Feat: 로그인 화면 UI 구현 #3",
  "started_at": "..."
}
```

**작성 규칙:** 특수문자/줄바꿈 금지, 작업 결과 중심

---

## 프로젝트 개요

Flutter 앱 개발부터 스토어 배포까지의 전체 과정을 경험하기 위한 실험용 프로젝트입니다.

### 프로젝트 목표

1. Flutter 기초 학습 및 실습
2. iOS/Android 앱 빌드
3. App Store / Google Play Store 배포 경험
4. 심사 과정 이해

### 기술 스택

- **Framework**: Flutter
- **Language**: Dart
- **IDE**: VS Code / Android Studio

---

## 프로젝트 구조

```
flutter-practice/
├── lib/                    # Dart 소스 코드
│   ├── main.dart           # 앱 진입점
│   ├── screens/            # 화면 위젯
│   ├── widgets/            # 재사용 컴포넌트
│   └── services/           # 비즈니스 로직
├── ios/                    # iOS 네이티브 설정
├── android/                # Android 네이티브 설정
├── test/                   # 테스트 코드
├── pubspec.yaml            # 패키지 의존성
└── .claude/                # Claude Code 설정
```

---

## 프로젝트 참조 문서

| 문서 | 설명 |
|------|------|
| `.claude/docs/notify-workflow.md` | Discord 알림 워크플로우 |
| `.claude/projects/README.md` | 대규모 프로젝트 관리 가이드 |

---

## 개발 명령어

```bash
# 의존성 설치
flutter pub get

# 개발 실행
flutter run

# 특정 디바이스에서 실행
flutter run -d <device_id>

# 빌드
flutter build apk          # Android APK (디버그)
flutter build apk --release # Android APK (릴리즈)
flutter build appbundle    # Android App Bundle (Play Store용)
flutter build ios          # iOS

# 테스트
flutter test

# 코드 분석
flutter analyze

# 코드 포맷팅
dart format .
```

---

## 코드 스타일 가이드

### Dart

- Dart 공식 스타일 가이드 준수
- `dart format` 자동 포맷팅 사용
- 가능한 `const` 생성자 사용
- 타입 명시 권장

### Flutter/Widget

- 위젯은 가능한 작게 분리
- StatelessWidget 우선, 필요시 StatefulWidget
- `const` 위젯 적극 활용

---

## 브랜치 전략

- `main`: 메인 브랜치
- `feat/*`: 기능 개발
- `fix/*`: 버그 수정

## 커밋 메시지 컨벤션

```
<Type>: <Subject> #<이슈번호>

Type 종류:
- feat: 새로운 기능
- fix: 버그 수정
- style: 스타일 수정 (코드 로직 변경 없음)
- refactor: 리팩토링
- docs: 문서 수정
- chore: 기타 작업
```

---

## 자주 사용하는 Claude Code 커맨드

- `/commit`: 커밋 생성
- `/pr`: PR 생성
- `/git-branch-sync`: PR merge 후 target branch를 현재 branch에 동기화

---

## 배포 체크리스트

### iOS (App Store)

- [ ] Bundle Identifier 설정
- [ ] 버전/빌드 번호 관리
- [ ] App Store Connect 앱 등록
- [ ] 스크린샷 준비 (6.5", 5.5")
- [ ] 앱 설명 작성
- [ ] 개인정보처리방침 URL
- [ ] Archive & Upload

### Android (Google Play)

- [ ] Application ID 설정
- [ ] 서명 키 생성 및 관리
- [ ] Google Play Console 앱 등록
- [ ] 스크린샷 준비
- [ ] 앱 설명 작성
- [ ] 개인정보처리방침 URL
- [ ] App Bundle 업로드

---

## 환경 설정

### Discord 알림

프로젝트 루트의 `.env.local` 파일에 webhook URL 설정:

```bash
PERSONAL_DISCORD_WEBHOOK_URL=https://discord.com/api/webhooks/xxx/xxx
```

세션 종료 시 작업 요약이 Discord로 전송됩니다.

### 주의사항

- Flutter SDK 설치 필요
- Xcode (iOS 빌드) / Android Studio (Android 빌드) 필요

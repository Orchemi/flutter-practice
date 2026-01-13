# Flutter Practice

Flutter 공부 및 실습을 위한 레파지토리

## 시작하기

### 1. 환경 설정

Flutter 개발 환경이 처음이라면 아래 가이드를 따라 설정하세요.

**[환경 설정 가이드 (macOS)](./docs/environment-setup.md)**

### 2. 환경 확인

이미 Flutter가 설치되어 있다면 환경을 확인합니다.

```bash
flutter doctor
```

모든 항목이 `[✓]`로 표시되면 준비 완료입니다.

### 3. 프로젝트 실행

```bash
# 의존성 설치
flutter pub get

# 앱 실행
flutter run
```

## 개발 명령어

```bash
# 의존성 설치
flutter pub get

# 개발 실행
flutter run

# 특정 디바이스에서 실행
flutter devices              # 디바이스 목록 확인
flutter run -d <device_id>   # 특정 디바이스 실행

# 빌드
flutter build apk            # Android APK
flutter build ios            # iOS

# 테스트
flutter test

# 코드 분석
flutter analyze

# 코드 포맷팅
dart format .
```

## 프로젝트 구조

```
flutter-practice/
├── lib/                    # Dart 소스 코드
│   ├── main.dart           # 앱 진입점
│   ├── app/                # 앱 설정 (테마, 라우팅)
│   ├── core/               # 공통 유틸리티
│   ├── features/           # 기능별 모듈
│   └── shared/             # 공유 컴포넌트
├── ios/                    # iOS 네이티브 설정
├── android/                # Android 네이티브 설정
├── test/                   # 테스트 코드
├── docs/                   # 문서
└── pubspec.yaml            # 패키지 의존성
```

## 문서

| 문서 | 설명 |
|------|------|
| [환경 설정 가이드](./docs/environment-setup.md) | macOS Flutter 개발 환경 설정 |

## 기술 스택

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: flutter_riverpod
- **Routing**: go_router

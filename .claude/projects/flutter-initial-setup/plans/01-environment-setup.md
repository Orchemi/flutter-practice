# Phase 1: 환경 설정

## 목표

> Flutter 개발 환경을 확인하고, 프로젝트를 생성합니다.

## React와 비교

| 단계          | React                 | Flutter                  |
| ------------- | --------------------- | ------------------------ |
| 환경 확인     | `node -v`, `npm -v`   | `flutter doctor`         |
| 프로젝트 생성 | `npx create-next-app` | `flutter create`         |
| 의존성 설치   | `npm install`         | `flutter pub get` (자동) |

## 태스크 요약

| ID        | 태스크                         | 상태 |
| --------- | ------------------------------ | ---- |
| TASK-0101 | Flutter SDK 설치 확인          | ✅   |
| TASK-0102 | flutter create로 프로젝트 생성 | ✅   |
| TASK-0103 | 불필요한 파일 정리             | ✅   |

---

## TASK-0101: Flutter SDK 설치 확인

### 개요

| 항목          | 내용    |
| ------------- | ------- |
| **상태**      | ✅ 완료 |
| **선행 조건** | 없음    |

### 왜 필요한가요?

React 개발을 위해 Node.js가 필요하듯, Flutter 개발을 위해 Flutter SDK가 필요합니다.
`flutter doctor` 명령어는 Node.js의 `npm doctor`와 비슷하게, 개발 환경이 제대로 설정되었는지 확인해줍니다.

### 체크리스트

#### 0단계: Flutter 설치 (미설치 시)

macOS 환경에서 Flutter 설치:

```bash
# 1. Flutter SDK 설치
brew install --cask flutter

# 2. Xcode Command Line Tools 설치 (iOS 개발 필수)
xcode-select --install

# 3. rbenv와 ruby-build 설치 (Ruby 버전 관리)
brew install rbenv ruby-build

# 4. rbenv 초기화 스크립트를 셸에 추가
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
source ~/.zshrc

# 5. Ruby 3.3.0 설치
rbenv install 3.3.0

# 6. 전역 Ruby 버전을 3.3.0으로 설정
rbenv global 3.3.0

# 7. 셸 재시작 또는 설정 다시 로드
source ~/.zshrc

# 8. Ruby 버전 확인 (3.3.0이어야 함)
ruby -v

# 9. CocoaPods 설치
gem install cocoapods
```

**체크리스트:**

- [ ] `brew install --cask flutter` 실행
- [ ] `xcode-select --install` 실행
- [ ] `brew install rbenv ruby-build` 실행
- [ ] `echo 'eval "$(rbenv init -)"' >> ~/.zshrc` 실행
- [ ] `source ~/.zshrc` 실행
- [ ] `rbenv install 3.3.0` 실행
- [ ] `rbenv global 3.3.0` 실행
- [ ] 터미널 재시작 또는 `source ~/.zshrc` 실행
- [ ] `ruby -v`로 3.3.0 확인
- [ ] `gem install cocoapods` 실행

**주의사항:**

- macOS에는 기본 Ruby 2.6이 포함되어 있지만, CocoaPods는 Ruby 3.0 이상 필요
- Apple Silicon (M1/M2/M3)에서는 rbenv 사용을 권장 (호환성 문제 최소화)
- Homebrew로 설치한 Ruby 대신 rbenv를 사용하면 버전 관리가 용이함

**트러블슈팅:**

만약 `gem install cocoapods` 실행 시 ffi 관련 에러가 발생하면:

```bash
# ffi 1.17.3 먼저 설치 (Ruby 2.6 호환 버전)
gem install ffi -v 1.17.3

# 또는 Apple Silicon용
gem install ffi -v 1.17.3 --platform arm64-darwin

# 이후 CocoaPods 재시도
gem install cocoapods

# ffi 설치 확인
gem list ffi
```

만약 그래도 문제가 있다면:

```bash
# ffi 완전 제거 후 재설치
gem uninstall ffi
gem install ffi
```

#### 1단계: Android Studio 설치 (Android 개발용)

Android 앱을 빌드하려면 Android Studio가 필요합니다.

```bash
# Android Studio 설치
brew install --cask android-studio
```

**Android Studio 초기 설정:**

Android Studio를 처음 실행하면 설정 마법사가 나타납니다:

1. **Android Studio 첫 실행 시:**

   - Welcome 화면에서 설정 마법사 시작
   - "Standard" 설치 타입 선택 (권장: 필요한 SDK 자동 설치)
   - 또는 "Custom" 선택 (고급 사용자용)
   - SDK 다운로드 및 설치 완료까지 대기

2. **이미 설치 마법사를 완료했다면:**

   - 메인 화면에서 바로 3단계로 이동

3. **SDK Command-line Tools 설치:**
   - Android Studio 메인 화면 우측 하단의 Settings 아이콘 클릭 (⚙️)
   - 또는 상단 메뉴: Android Studio > Settings (⌘,)
   - Appearance & Behavior > System Settings > Android SDK
   - 상단 탭에서 **SDK Tools** 클릭
   - ☐ **Android SDK Command-line Tools (latest)** 체크
   - 우측 하단 **Apply** 버튼 클릭
   - 다운로드 및 설치 완료까지 대기
   - **OK** 버튼으로 닫기

**체크리스트:**

- [ ] `brew install --cask android-studio` 실행
- [ ] Android Studio 실행 및 Standard 설치
- [ ] SDK Tools에서 Command-line Tools 설치
- [ ] Android SDK 라이선스 승인

#### 2단계: Android 라이선스 승인

```bash
# Android SDK 라이선스 모두 승인
flutter doctor --android-licenses

# 모든 라이선스에 'y' 입력
```

**주의사항:**

- 모든 라이선스 약관에 `y`를 입력해야 함
- 약 7-8개의 라이선스가 나타남

**체크리스트:**

- [ ] `flutter doctor --android-licenses` 실행
- [ ] 모든 라이선스에 `y` 입력

#### 3단계: Flutter 설치 확인

- [ ] `flutter --version` 실행하여 버전 확인
- [ ] `flutter doctor` 실행하여 환경 점검

#### 4단계: 결과 해석

`flutter doctor` 출력 예시:

```
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain
[✓] Xcode (iOS 개발용)
[✓] Chrome (웹 개발용)
[✓] VS Code
```

- `[✓]` : 정상
- `[!]` : 경고 (일부 기능 제한, 진행 가능)
- `[✗]` : 오류 (해결 필요)

### Claude Code 지침

```markdown
TASK-0101을 진행해줘.
flutter --version과 flutter doctor를 실행해서 결과를 보여줘.
```

### 완료 기준

- [ ] `flutter --version` 출력 확인
- [ ] `flutter doctor` 출력에서 Flutter 항목이 `[✓]`
- [ ] `flutter doctor` 출력에서 Android toolchain 항목이 `[✓]`

### 트러블슈팅

**문제 1: cmdline-tools component is missing**

```
✗ cmdline-tools component is missing.
  Try installing or updating Android Studio.
```

**해결 방법:**

1. Android Studio 실행
2. Settings (⌘,) > Android SDK > SDK Tools
3. "Android SDK Command-line Tools" 체크 후 Apply

**문제 2: Android license status unknown**

```
✗ Android license status unknown.
  Run `flutter doctor --android-licenses` to accept the SDK licenses.
```

**해결 방법:**

```bash
flutter doctor --android-licenses
# 모든 라이선스에 'y' 입력
```

**문제 3: ANDROID_HOME 환경 변수 미설정**

**해결 방법:**

```bash
# ~/.zshrc에 추가
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc
```

### 사용자 검수 포인트

1. Flutter 버전이 출력되는지 확인
2. `flutter doctor` 결과에서 심각한 오류(`[✗]`)가 없는지 확인
3. Android toolchain이 `[✓]`로 표시되는지 확인
4. 최소 Android 또는 iOS 중 하나 이상 개발 가능한지 확인

---

## TASK-0102: flutter create로 프로젝트 생성

### 개요

| 항목          | 내용           |
| ------------- | -------------- |
| **상태**      | ✅ 완료        |
| **선행 조건** | TASK-0101 완료 |

### 왜 필요한가요?

`npx create-next-app`이 Next.js 프로젝트 뼈대를 만들어주듯,
`flutter create`가 Flutter 프로젝트 뼈대를 만들어줍니다.

### 체크리스트

#### 1단계: 현재 디렉토리 확인

- [ ] 현재 위치가 프로젝트 루트인지 확인
- [ ] 이미 Flutter 프로젝트가 있는지 확인 (`pubspec.yaml` 존재 여부)

#### 2단계: 프로젝트 생성

**이미 있는 경우**: 기존 프로젝트 활용
**없는 경우**: 새로 생성

```bash
# 현재 디렉토리에 프로젝트 생성 (디렉토리명 = 앱 이름)
flutter create .

# 또는 특정 이름으로 생성
flutter create --org com.example flutter_practice
```

#### 3단계: 생성된 구조 확인

```
flutter-practice/
├── android/          # Android 네이티브 코드 (건드릴 일 거의 없음)
├── ios/              # iOS 네이티브 코드 (건드릴 일 거의 없음)
├── lib/              # ⭐ Dart 소스 코드 (여기서 개발)
│   └── main.dart     # 앱 진입점 (React의 index.js)
├── test/             # 테스트 코드
├── pubspec.yaml      # ⭐ 패키지 설정 (package.json)
└── analysis_options.yaml  # lint 설정 (.eslintrc)
```

### Claude Code 지침

```markdown
TASK-0102를 진행해줘.
현재 디렉토리에 Flutter 프로젝트가 있는지 확인하고,
없으면 flutter create로 생성해줘.
```

### 완료 기준

- [ ] `pubspec.yaml` 파일 존재
- [ ] `lib/main.dart` 파일 존재
- [ ] `flutter pub get` 실행 성공

### 사용자 검수 포인트

1. 프로젝트 루트에 `pubspec.yaml`이 생성되었는지 확인
2. `lib/main.dart` 파일이 있는지 확인
3. 에러 메시지 없이 완료되었는지 확인

---

## TASK-0103: 불필요한 파일 정리

### 개요

| 항목          | 내용           |
| ------------- | -------------- |
| **상태**      | ✅ 완료        |
| **선행 조건** | TASK-0102 완료 |

### 왜 필요한가요?

`create-next-app`으로 생성하면 예제 코드가 들어있듯,
`flutter create`도 카운터 앱 예제 코드가 들어있습니다.
깔끔하게 시작하기 위해 예제 코드를 정리합니다.

### 체크리스트

#### 1단계: main.dart 정리

기존 카운터 앱 예제를 최소한의 코드로 교체:

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```

#### 2단계: 테스트 파일 정리

- [ ] `test/widget_test.dart` 내용 정리 또는 삭제

### Claude Code 지침

```markdown
TASK-0103을 진행해줘.
lib/main.dart를 최소한의 Hello World 코드로 정리해줘.
```

### 완료 기준

- [ ] `lib/main.dart`가 깔끔한 시작 코드로 교체됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. `lib/main.dart` 파일 내용 확인
2. 코드가 간결하고 이해하기 쉬운지 확인
3. `flutter run` 실행 시 "Hello, Flutter!" 텍스트가 보이는지 확인 (선택)

---

## 진행 현황

```
Phase 1 진행률: [██████████] 100% ✅

TASK-0101 (SDK 확인):     [██████████] 100% ✅
TASK-0102 (프로젝트 생성): [██████████] 100% ✅
TASK-0103 (파일 정리):    [██████████] 100% ✅
```

### 완료 내역

**2026-01-12 완료**

1. **TASK-0101**: Flutter SDK 설치 확인

   - rbenv 기반 Ruby 3.3.0 설치
   - CocoaPods 설치
   - Android Studio 설치 및 SDK Command-line Tools 설정
   - Android 라이선스 승인
   - `flutter doctor` 모든 항목 ✓

2. **TASK-0102**: flutter create로 프로젝트 생성

   - Organization: com.orchemi
   - Project name: flutter_practice
   - 128개 파일 생성
   - 의존성 자동 설치 완료

3. **TASK-0103**: 불필요한 파일 정리
   - lib/main.dart → 깔끔한 Hello World
   - lib/examples/counter_example.dart → 학습용 카운터 앱 백업
   - lib/examples/README.md → 학습 가이드
   - .gitignore → Flutter 표준 항목 추가
   - `flutter analyze` 통과

## 다음 단계

Phase 1 완료 후 → [Phase 2: 프로젝트 구조](./02-project-structure.md)로 이동

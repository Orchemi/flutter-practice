# Flutter 개발 환경 설정 가이드 (macOS)

이 문서는 macOS에서 Flutter 개발 환경을 처음부터 설정하는 방법을 안내합니다.

## 목차

1. [사전 요구사항](#사전-요구사항)
2. [Step 1: Homebrew 설치](#step-1-homebrew-설치)
3. [Step 2: Flutter SDK 설치](#step-2-flutter-sdk-설치)
4. [Step 3: Xcode 설치 (iOS 개발용)](#step-3-xcode-설치-ios-개발용)
5. [Step 4: Ruby 환경 설정 (CocoaPods용)](#step-4-ruby-환경-설정-cocoapods용)
6. [Step 5: CocoaPods 설치](#step-5-cocoapods-설치)
7. [Step 6: Android Studio 설치 (Android 개발용)](#step-6-android-studio-설치-android-개발용)
8. [Step 7: Android 환경 변수 설정](#step-7-android-환경-변수-설정)
9. [Step 8: Android 라이선스 승인](#step-8-android-라이선스-승인)
10. [Step 9: 최종 확인](#step-9-최종-확인)
11. [트러블슈팅](#트러블슈팅)

---

## 사전 요구사항

- macOS 12.0 (Monterey) 이상
- 약 10GB 이상의 여유 디스크 공간
- 인터넷 연결

---

## Step 1: Homebrew 설치

Homebrew는 macOS용 패키지 관리자입니다. 이미 설치되어 있다면 건너뛰세요.

### 설치 확인

```bash
brew --version
```

### 설치 방법

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

설치 후 터미널에 출력되는 안내에 따라 PATH 설정을 완료하세요.

---

## Step 2: Flutter SDK 설치

### 설치

```bash
brew install --cask flutter
```

### 설치 확인

```bash
flutter --version
```

정상 출력 예시:
```
Flutter 3.x.x • channel stable
```

---

## Step 3: Xcode 설치 (iOS 개발용)

iOS 앱을 빌드하려면 Xcode가 필요합니다.

### 3-1. Xcode 설치

App Store에서 **Xcode**를 검색하여 설치합니다. (용량이 크므로 시간이 걸릴 수 있습니다)

### 3-2. Xcode Command Line Tools 설치

```bash
xcode-select --install
```

### 3-3. Xcode 라이선스 동의

```bash
sudo xcodebuild -license accept
```

### 설치 확인

```bash
xcodebuild -version
```

---

## Step 4: Ruby 환경 설정 (CocoaPods용)

CocoaPods는 iOS 의존성 관리 도구이며, Ruby 3.0 이상이 필요합니다.
macOS 기본 Ruby는 2.6이므로 rbenv를 사용하여 최신 버전을 설치합니다.

### 4-1. rbenv 설치

```bash
brew install rbenv ruby-build
```

### 4-2. 셸 설정 추가

```bash
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
source ~/.zshrc
```

> **참고**: bash를 사용하는 경우 `~/.zshrc` 대신 `~/.bash_profile`을 사용하세요.

### 4-3. Ruby 3.3.0 설치

```bash
rbenv install 3.3.0
rbenv global 3.3.0
source ~/.zshrc
```

### 설치 확인

```bash
ruby -v
```

`ruby 3.3.0`이 출력되어야 합니다.

> **주의**: 여전히 `ruby 2.6.x`가 나온다면 터미널을 완전히 종료 후 다시 열어보세요.

---

## Step 5: CocoaPods 설치

```bash
gem install cocoapods
```

### 설치 확인

```bash
pod --version
```

---

## Step 6: Android Studio 설치 (Android 개발용)

Android 앱을 빌드하려면 Android Studio와 Android SDK가 필요합니다.

### 6-1. Android Studio 설치

```bash
brew install --cask android-studio
```

### 6-2. Android Studio 초기 설정

1. `/Applications/Android Studio.app` 실행
2. 설치 마법사에서 **Standard** 선택 (권장)
3. SDK 다운로드 완료까지 대기

### 6-3. Android SDK Command-line Tools 설치

1. Android Studio 메인 화면에서 **Settings** (⌘,) 클릭
2. **Appearance & Behavior > System Settings > Android SDK** 이동
3. 상단 **SDK Tools** 탭 클릭
4. **Android SDK Command-line Tools (latest)** 체크
5. **Apply** 클릭 → 설치 완료 대기 → **OK**

---

## Step 7: Android 환경 변수 설정

### 환경 변수 추가

```bash
echo '' >> ~/.zshrc
echo '# Android SDK' >> ~/.zshrc
echo 'export ANDROID_HOME=$HOME/Library/Android/sdk' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/emulator' >> ~/.zshrc
echo 'export PATH=$PATH:$ANDROID_HOME/platform-tools' >> ~/.zshrc
source ~/.zshrc
```

### 설정 확인

```bash
echo $ANDROID_HOME
```

`/Users/[사용자명]/Library/Android/sdk`가 출력되어야 합니다.

---

## Step 8: Android 라이선스 승인

```bash
flutter doctor --android-licenses
```

모든 라이선스 질문에 `y`를 입력합니다. (약 7-8개)

---

## Step 9: 최종 확인

```bash
flutter doctor
```

### 성공 시 출력

```
Doctor summary (to see all details, run flutter doctor -v):
[✓] Flutter (Channel stable, 3.x.x)
[✓] Android toolchain - develop for Android devices
[✓] Xcode - develop for iOS and macOS
[✓] Chrome - develop for the web
[✓] Connected device
[✓] Network resources

• No issues found!
```

모든 항목이 `[✓]`로 표시되면 환경 설정 완료입니다.

---

## 트러블슈팅

### 문제 1: cmdline-tools component is missing

```
✗ cmdline-tools component is missing
```

**해결**: Android Studio > Settings > Android SDK > SDK Tools에서 "Android SDK Command-line Tools" 설치

### 문제 2: Android license status unknown

```
✗ Android license status unknown
```

**해결**:
```bash
flutter doctor --android-licenses
```

### 문제 3: CocoaPods 설치 시 ffi 에러

```bash
# ffi 먼저 설치
gem install ffi -v 1.17.3

# 이후 CocoaPods 설치
gem install cocoapods
```

### 문제 4: Ruby 버전이 변경되지 않음

터미널을 완전히 종료 후 다시 열거나:

```bash
source ~/.zshrc
ruby -v
```

rbenv가 제대로 초기화되었는지 확인:

```bash
which ruby
# /Users/[사용자명]/.rbenv/shims/ruby 가 나와야 함
```

### 문제 5: ANDROID_HOME 환경 변수 미설정

```bash
# ~/.zshrc에 추가되었는지 확인
grep ANDROID_HOME ~/.zshrc

# 없다면 Step 7 다시 진행
```

---

## 앱 실행하기

환경 설정이 완료되면 프로젝트를 실행할 수 있습니다.

```bash
# 의존성 설치
flutter pub get

# 사용 가능한 디바이스 확인
flutter devices

# 앱 실행
flutter run

# 특정 디바이스에서 실행
flutter run -d <device_id>
```

---

## 참고 자료

- [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install/macos)
- [Dart 공식 문서](https://dart.dev/guides)
- [CocoaPods 공식 사이트](https://cocoapods.org/)

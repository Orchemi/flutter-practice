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
11. [iOS 시뮬레이터에서 앱 실행](#ios-시뮬레이터에서-앱-실행)
12. [Android 에뮬레이터에서 앱 실행](#android-에뮬레이터에서-앱-실행)
13. [트러블슈팅](#트러블슈팅)

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

### 문제 6: Android 에뮬레이터에서 브라우저가 열림

Android 에뮬레이터에서 앱 대신 브라우저(localhost:xxxxx)가 열리는 경우:

**원인**: `flutter run` 실행 시 Chrome이 기본 선택됨

**해결**: 명시적으로 Android 에뮬레이터 지정
```bash
# 디바이스 ID 확인
flutter devices

# Android 에뮬레이터 명시적 지정
flutter run -d emulator-5554
```

### 문제 7: CocoaPods not installed (iOS)

```
✗ CocoaPods not installed.
```

**해결**:
```bash
# Homebrew로 설치 (권장)
brew install cocoapods

# 설치 후 iOS 의존성 설치
cd ios && pod install && cd ..
```

### 문제 8: Android 에뮬레이터가 offline 상태

```
Device emulator-5554 is offline.
```

**해결**: 에뮬레이터 부팅 완료까지 대기 (10-30초)
```bash
# 잠시 대기 후 다시 확인
sleep 10 && flutter devices
```

### 문제 9: 첫 Android 빌드가 오래 걸림

첫 Android 빌드 시 NDK, CMake, Build-Tools가 자동 설치됩니다.

**예상 소요 시간**: 5-10분

빌드 캐시 문제 발생 시:
```bash
cd android
./gradlew clean
cd ..
flutter run -d emulator-5554
```

### 문제 10: iOS 시뮬레이터가 목록에 없음

```bash
# Xcode 시뮬레이터 런타임 확인
xcrun simctl list runtimes

# 시뮬레이터 목록 확인
xcrun simctl list devices
```

Xcode에서 추가 시뮬레이터 다운로드:
1. Xcode > Settings (⌘,)
2. Platforms 탭
3. 원하는 iOS 버전 다운로드

---

## iOS 시뮬레이터에서 앱 실행

### 1. iOS 의존성 설치 (최초 1회)

프로젝트를 처음 실행하기 전에 iOS 의존성을 설치합니다.

```bash
# 프로젝트 루트에서
cd ios
pod install
cd ..
```

> **참고**: CocoaPods가 설치되어 있지 않으면 `brew install cocoapods` 실행

### 2. iOS 시뮬레이터 시작

```bash
# 사용 가능한 시뮬레이터 목록 확인
flutter emulators

# iOS 시뮬레이터 시작
flutter emulators --launch apple_ios_simulator
```

또는 Xcode에서 직접:
1. Xcode 실행
2. 메뉴 **Window > Devices and Simulators** (⌘⇧2)
3. 원하는 시뮬레이터 선택 후 부팅

### 3. 앱 실행

```bash
# 연결된 디바이스 확인
flutter devices

# iOS 시뮬레이터에서 실행
flutter run -d <simulator_id>

# 예시
flutter run -d 559086D0-91BD-4BE2-8CE6-FD5BD857A649
```

> **팁**: `flutter run`만 실행하면 여러 디바이스 중 선택할 수 있습니다.

---

## Android 에뮬레이터에서 앱 실행

### 1. Android 에뮬레이터 생성 (최초 1회)

Android Studio에서 에뮬레이터를 생성합니다.

1. Android Studio 실행
2. 메인 화면에서 **More Actions > Virtual Device Manager** 클릭
3. **Create Device** 클릭
4. 디바이스 선택 (예: Pixel 8, Medium Phone)
5. 시스템 이미지 선택 (최신 API 권장)
6. **Finish** 클릭

### 2. Android 에뮬레이터 시작

```bash
# 사용 가능한 에뮬레이터 목록 확인
flutter emulators

# Android 에뮬레이터 시작 (이름은 flutter emulators 결과 참조)
flutter emulators --launch <emulator_name>

# 예시
flutter emulators --launch Medium_Phone_API_36.1
```

또는 Android Studio에서 직접:
1. Android Studio 실행
2. **More Actions > Virtual Device Manager**
3. 원하는 에뮬레이터 옆 ▶️ 버튼 클릭

### 3. 앱 실행

```bash
# 연결된 디바이스 확인
flutter devices

# Android 에뮬레이터에서 실행
flutter run -d emulator-5554
```

### 4. 첫 빌드 시 자동 설치 항목

Android 앱을 처음 빌드할 때 다음 항목들이 자동으로 설치됩니다:
- NDK (Native Development Kit)
- Android SDK Build-Tools
- CMake

첫 빌드는 **5-10분** 정도 소요될 수 있습니다. 이후 빌드는 빠릅니다.

---

## 앱 실행 요약

### 빠른 시작 명령어

```bash
# 1. 의존성 설치
flutter pub get

# 2. iOS 의존성 설치 (iOS 실행 시)
cd ios && pod install && cd ..

# 3. 사용 가능한 디바이스/에뮬레이터 확인
flutter devices
flutter emulators

# 4. 시뮬레이터/에뮬레이터 시작
flutter emulators --launch apple_ios_simulator      # iOS
flutter emulators --launch <android_emulator_name>  # Android

# 5. 앱 실행
flutter run                    # 디바이스 선택 프롬프트
flutter run -d <device_id>     # 특정 디바이스 지정
```

### Hot Reload 단축키

앱 실행 중 터미널에서:

| 키 | 동작 | 설명 |
|----|------|------|
| `r` | Hot Reload | 코드 변경 반영 (상태 유지) |
| `R` | Hot Restart | 앱 재시작 (상태 초기화) |
| `q` | 종료 | 앱 종료 |

### 동시 실행

iOS와 Android를 동시에 테스트하려면 터미널을 2개 열고 각각 실행:

```bash
# 터미널 1: iOS
flutter run -d <ios_simulator_id>

# 터미널 2: Android
flutter run -d emulator-5554
```

---

## 참고 자료

- [Flutter 공식 설치 가이드](https://docs.flutter.dev/get-started/install/macos)
- [Dart 공식 문서](https://dart.dev/guides)
- [CocoaPods 공식 사이트](https://cocoapods.org/)

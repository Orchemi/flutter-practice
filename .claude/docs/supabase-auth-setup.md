# Supabase Auth 설정 가이드

Flutter 앱에서 Google + Apple 소셜 로그인을 사용하기 위한 전체 설정 과정입니다.

---

## 1. Supabase 프로젝트 생성

### 1-1. 프로젝트 만들기

1. https://supabase.com 접속 후 로그인
2. **New Project** 클릭
3. Organization 선택 (없으면 생성)
4. 프로젝트 정보 입력:
   - **Name**: `flutter-practice` (자유)
   - **Database Password**: 안전한 비밀번호 입력 (메모 필수)
   - **Region**: Northeast Asia (Tokyo) - 한국에서 가장 가까움
5. **Create new project** 클릭 후 프로비저닝 완료 대기

### 1-2. URL과 anon key 확인

1. 프로젝트 대시보드 > 좌측 메뉴 > **Project Settings** (톱니바퀴)
2. **API** 탭 클릭
3. 아래 두 값을 복사해 둡니다:

| 항목 | 위치 | 예시 |
|------|------|------|
| **Project URL** | `URL` 섹션 | `https://abcdefgh.supabase.co` |
| **anon (public) key** | `Project API keys` 섹션 | `eyJhbGciOiJIUzI1NiIs...` |

> 이 두 값은 나중에 `--dart-define`으로 앱에 전달합니다.

---

## 2. Google OAuth 설정

Google 로그인은 **Google Cloud Console**과 **Supabase Dashboard** 양쪽 모두 설정이 필요합니다.

### 2-1. Google Cloud 프로젝트 생성

1. https://console.cloud.google.com 접속
2. 상단 프로젝트 선택 드롭다운 > **새 프로젝트**
   - 프로젝트 이름: `flutter-practice` (자유)
   - **만들기** 클릭

### 2-2. OAuth 동의 화면 설정

1. 좌측 메뉴 > **API 및 서비스** > **OAuth 동의 화면**
2. **시작하기** 또는 **동의 화면 구성** 클릭
3. 앱 정보 입력:
   - **앱 이름**: `Flutter Practice`
   - **사용자 지원 이메일**: 본인 이메일
   - **개발자 연락처 이메일**: 본인 이메일
4. **Scopes** 단계:
   - **ADD OR REMOVE SCOPES** 클릭
   - `email`, `profile`, `openid` 체크 후 저장
5. **Test users** 단계:
   - 테스트 중에는 본인 Google 계정 이메일 추가
6. **저장 후 계속**

> 참고: 앱이 "테스트" 상태일 때는 등록된 테스트 사용자만 로그인 가능합니다.

### 2-3. OAuth Client ID 생성 - Web 클라이언트

Supabase가 Google과 통신할 때 사용하는 **Web Client ID**입니다.

1. 좌측 메뉴 > **API 및 서비스** > **사용자 인증 정보**
2. **+ 사용자 인증 정보 만들기** > **OAuth 클라이언트 ID**
3. 설정:
   - **애플리케이션 유형**: `웹 애플리케이션`
   - **이름**: `flutter-practice-web`
   - **승인된 리디렉션 URI** 추가:
     ```
     https://<YOUR_SUPABASE_PROJECT_ID>.supabase.co/auth/v1/callback
     ```
     (`<YOUR_SUPABASE_PROJECT_ID>`는 Supabase URL에서 `https://` 뒤, `.supabase.co` 앞 부분)
4. **만들기** 클릭
5. **클라이언트 ID**와 **클라이언트 시크릿** 복사 (둘 다 필요)

> 예시 클라이언트 ID: `123456789-abcdef.apps.googleusercontent.com`

### 2-4. OAuth Client ID 생성 - iOS 클라이언트

iOS 네이티브 Google Sign-In에 필요합니다.

1. **+ 사용자 인증 정보 만들기** > **OAuth 클라이언트 ID**
2. 설정:
   - **애플리케이션 유형**: `iOS`
   - **이름**: `flutter-practice-ios`
   - **번들 ID**: `com.orchemi.flutterPractice`
3. **만들기** 클릭
4. **클라이언트 ID** 복사

### 2-5. OAuth Client ID 생성 - Android 클라이언트

Android 네이티브 Google Sign-In에 필요합니다.

1. **+ 사용자 인증 정보 만들기** > **OAuth 클라이언트 ID**
2. 설정:
   - **애플리케이션 유형**: `Android`
   - **이름**: `flutter-practice-android`
   - **패키지 이름**: `com.orchemi.flutter_practice`
   - **SHA-1 인증서 지문**: 아래 명령어로 확인
3. **만들기** 클릭

#### SHA-1 지문 확인 방법 (디버그용)

```bash
# macOS/Linux
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

# 출력에서 SHA1 값 복사 (예: AA:BB:CC:DD:...)
```

> `~/.android/debug.keystore`가 없으면 Android 에뮬레이터를 한 번 실행하면 자동 생성됩니다.

### 2-6. Supabase에 Google Provider 등록

1. Supabase 대시보드 > 좌측 메뉴 > **Authentication**
2. **Providers** 탭 클릭
3. **Google** 찾아서 토글 **ON**
4. 입력:
   - **Client ID (for OAuth)**: 2-3에서 만든 **Web 클라이언트 ID**
   - **Client Secret (for OAuth)**: 2-3에서 만든 **Web 클라이언트 시크릿**
5. **Save** 클릭

---

## 3. Apple OAuth 설정 (iOS 전용)

> Apple 로그인은 Apple Developer Program 멤버십($99/년)이 필요합니다.
> 멤버십이 없다면 이 단계를 건너뛰어도 됩니다. Google 로그인만으로도 테스트 가능합니다.

### 3-1. Apple Developer에서 App ID 등록

1. https://developer.apple.com/account 접속
2. **Certificates, Identifiers & Profiles** > **Identifiers**
3. **+** 버튼 > **App IDs** 선택 > **Continue**
4. 설정:
   - **Description**: `Flutter Practice`
   - **Bundle ID**: `com.orchemi.flutterPractice` (Explicit)
   - **Capabilities**에서 **Sign In with Apple** 체크
5. **Continue** > **Register**

### 3-2. Service ID 생성

1. **Identifiers** > **+** 버튼 > **Services IDs** 선택 > **Continue**
2. 설정:
   - **Description**: `Flutter Practice Auth`
   - **Identifier**: `com.orchemi.flutterPractice.auth` (자유, 단 App ID와 달라야 함)
3. **Continue** > **Register**
4. 생성된 Service ID 클릭 > **Sign In with Apple** 체크 > **Configure**
5. 설정:
   - **Primary App ID**: 3-1에서 만든 App ID 선택
   - **Domains and Subdomains**: `<YOUR_SUPABASE_PROJECT_ID>.supabase.co`
   - **Return URLs**: `https://<YOUR_SUPABASE_PROJECT_ID>.supabase.co/auth/v1/callback`
6. **Save** > **Continue** > **Save**

### 3-3. Private Key 생성

1. **Keys** > **+** 버튼
2. 설정:
   - **Key Name**: `Flutter Practice Auth Key`
   - **Sign In with Apple** 체크 > **Configure** > App ID 선택 > **Save**
3. **Continue** > **Register**
4. **Download** 클릭하여 `.p8` 파일 저장 (한 번만 다운로드 가능!)
5. **Key ID** 메모

### 3-4. Supabase에 Apple Provider 등록

1. Supabase 대시보드 > **Authentication** > **Providers**
2. **Apple** 토글 **ON**
3. 입력:
   - **Client ID (for OAuth)**: 3-2에서 만든 **Service ID** (예: `com.orchemi.flutterPractice.auth`)
   - **Secret Key (for OAuth)**: 3-3에서 다운로드한 `.p8` 파일 내용 전체 복사-붙여넣기
   - **Key ID**: 3-3에서 메모한 Key ID
   - **Team ID**: Apple Developer 계정 우상단에서 확인 (10자리 영숫자)
4. **Save** 클릭

---

## 4. Supabase Redirect URL 설정

1. Supabase 대시보드 > **Authentication** > **URL Configuration**
2. **Redirect URLs** 섹션에서 **Add URL** 클릭
3. 아래 URL 추가:
   ```
   com.orchemi.flutter-practice://login-callback
   ```
4. **Save** 클릭

---

## 5. 앱 실행

모든 설정이 완료되면 아래 명령어로 앱을 실행합니다:

```bash
flutter run \
  --dart-define=SUPABASE_URL=https://<PROJECT_ID>.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=eyJ... \
  --dart-define=GOOGLE_WEB_CLIENT_ID=xxx.apps.googleusercontent.com \
  --dart-define=GOOGLE_IOS_CLIENT_ID=yyy.apps.googleusercontent.com
```

| 변수 | 값 출처 |
|------|---------|
| `SUPABASE_URL` | 1-2에서 확인한 Project URL |
| `SUPABASE_ANON_KEY` | 1-2에서 확인한 anon public key |
| `GOOGLE_WEB_CLIENT_ID` | 2-3에서 만든 Web 클라이언트 ID |
| `GOOGLE_IOS_CLIENT_ID` | 2-4에서 만든 iOS 클라이언트 ID |

### 편하게 실행하기

매번 긴 명령어를 입력하기 번거로우면 `.env.local` 파일을 만들어 참고용으로 사용하세요:

```bash
# .env.local (gitignore에 포함되어 있음 - 커밋 안 됨)
SUPABASE_URL=https://abcdefgh.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
GOOGLE_WEB_CLIENT_ID=123456789-abc.apps.googleusercontent.com
GOOGLE_IOS_CLIENT_ID=123456789-def.apps.googleusercontent.com
```

---

## 6. 테스트 체크리스트

- [ ] Supabase 프로젝트 생성 및 URL/key 확인
- [ ] Google Cloud OAuth 동의 화면 설정
- [ ] Google Web Client ID 생성 + Supabase에 등록
- [ ] Google iOS Client ID 생성
- [ ] Google Android Client ID 생성 (SHA-1 포함)
- [ ] Supabase Redirect URL 추가
- [ ] (선택) Apple Developer에서 App ID, Service ID, Key 생성
- [ ] (선택) Supabase에 Apple Provider 등록
- [ ] `flutter run --dart-define=...`으로 앱 실행
- [ ] Step 2 > Auth 탭에서 Google 로그인 테스트

---

## 트러블슈팅

### "Google ID Token을 가져올 수 없습니다"
- Google Cloud Console에서 OAuth 동의 화면이 제대로 설정되었는지 확인
- Web Client ID의 리디렉션 URI가 Supabase callback URL과 일치하는지 확인

### "redirect_uri_mismatch" 오류
- Google Cloud Console의 **승인된 리디렉션 URI**에 `https://<PROJECT_ID>.supabase.co/auth/v1/callback`이 정확히 등록되어 있는지 확인

### iOS에서 Google 로그인이 안 됨
- iOS Client ID가 올바른 번들 ID(`com.orchemi.flutterPractice`)로 생성되었는지 확인
- `GOOGLE_IOS_CLIENT_ID` dart-define 값이 iOS Client ID인지 확인 (Web이 아님)

### Android에서 Google 로그인이 안 됨
- SHA-1 지문이 디버그 키스토어의 것과 일치하는지 확인
- 패키지 이름이 `com.orchemi.flutter_practice`인지 확인

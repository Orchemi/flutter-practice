# Phase 5: 라우팅

## 목표

> 화면 간 이동(네비게이션)을 위한 라우팅 시스템을 구축합니다.

## React와 비교

| React Router       | go_router (Flutter)    | 설명                 |
| ------------------ | ---------------------- | -------------------- |
| `<BrowserRouter>`  | `GoRouter()`           | 라우터 인스턴스      |
| `<Route path="/">` | `GoRoute(path: '/')`   | 라우트 정의          |
| `useNavigate()`    | `context.go()`         | 프로그래밍 방식 이동 |
| `<Link to="/">`    | `context.go('/')`      | 링크 이동            |
| `useParams()`      | `state.pathParameters` | URL 파라미터         |
| Nested Routes      | `routes: [...]`        | 중첩 라우트          |

## 태스크 요약

| ID        | 태스크                  | 상태 |
| --------- | ----------------------- | ---- |
| TASK-0501 | 라우트 경로 상수 정의   | ✅   |
| TASK-0502 | GoRouter 설정           | ✅   |
| TASK-0503 | main.dart에 라우터 적용 | ✅   |

---

## TASK-0501: 라우트 경로 상수 정의

### 개요

| 항목          | 내용         |
| ------------- | ------------ |
| **상태**      | ✅ 완료      |
| **선행 조건** | Phase 4 완료 |

### 왜 필요한가요?

React Router에서 경로를 상수로 관리하듯,
Flutter에서도 경로 문자열을 한 곳에서 관리하면 오타를 방지하고 유지보수가 쉬워집니다.

### 체크리스트

#### 1단계: 라우트 경로 상수 파일 생성

`lib/core/router/app_routes.dart`:

````dart
/// 앱에서 사용하는 라우트 경로 상수
///
/// React Router의 path 문자열과 동일한 역할
///
/// 사용법:
/// ```dart
/// context.go(AppRoutes.home);
/// context.go(AppRoutes.settings);
/// ```
abstract class AppRoutes {
  /// 홈 화면
  static const String home = '/';

  /// 설정 화면
  static const String settings = '/settings';

  // === 파라미터가 있는 라우트 예시 ===
  // static const String profile = '/profile/:id';
  // static String profileWithId(String id) => '/profile/$id';
}
````

### Claude Code 지침

```markdown
TASK-0501을 진행해줘.
lib/core/router/app_routes.dart 파일을 위 내용으로 생성해줘.
```

### 완료 기준

- [ ] `lib/core/router/app_routes.dart` 파일 생성됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. 파일이 올바른 위치에 생성되었는지 확인
2. 경로 상수가 직관적인지 확인

---

## TASK-0502: GoRouter 설정

### 개요

| 항목          | 내용           |
| ------------- | -------------- |
| **상태**      | ✅ 완료        |
| **선행 조건** | TASK-0501 완료 |

### 왜 필요한가요?

React에서 `<Routes>` 컴포넌트 안에 모든 라우트를 정의하듯,
Flutter에서도 라우트를 한 곳에서 관리합니다.

### 체크리스트

#### 1단계: 라우터 설정 파일 생성

`lib/core/router/app_router.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../../features/home/presentation/screens/home_screen.dart';

/// 앱 라우터 설정
///
/// React Router의 createBrowserRouter와 유사
final GoRouter appRouter = GoRouter(
  // 초기 경로 (React Router의 initialEntries)
  initialLocation: AppRoutes.home,

  // 디버그 로그 (개발 중에만 true)
  debugLogDiagnostics: true,

  // 라우트 정의 (React Router의 routes 배열)
  routes: [
    GoRoute(
      path: AppRoutes.home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),

    // 설정 화면 (나중에 추가)
    // GoRoute(
    //   path: AppRoutes.settings,
    //   name: 'settings',
    //   builder: (context, state) => const SettingsScreen(),
    // ),
  ],

  // 에러 페이지 (404)
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '404',
            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text('페이지를 찾을 수 없습니다: ${state.uri}'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go(AppRoutes.home),
            child: const Text('홈으로 이동'),
          ),
        ],
      ),
    ),
  ),
);
```

### Claude Code 지침

```markdown
TASK-0502를 진행해줘.
lib/core/router/app_router.dart 파일을 위 내용으로 생성해줘.
```

### 완료 기준

- [ ] `lib/core/router/app_router.dart` 파일 생성됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. 라우터 파일 구조 확인
2. React Router와 비슷한 구조인지 확인
3. 404 에러 페이지가 정의되었는지 확인

---

## TASK-0503: main.dart에 라우터 적용

### 개요

| 항목          | 내용           |
| ------------- | -------------- |
| **상태**      | ✅ 완료        |
| **선행 조건** | TASK-0502 완료 |

### 왜 필요한가요?

정의한 라우터를 앱에 연결해야 실제로 라우팅이 동작합니다.
React에서 `<RouterProvider router={router} />`를 루트에 추가하는 것과 같습니다.

### 체크리스트

#### 1단계: main.dart 수정

```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp → MaterialApp.router로 변경!
    return MaterialApp.router(
      title: 'Flutter Practice',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // 라우터 설정 연결
      routerConfig: appRouter,
    );
  }
}
```

**중요**: `MaterialApp`에서 `MaterialApp.router`로 변경해야 합니다!

### Claude Code 지침

```markdown
TASK-0503을 진행해줘.
main.dart를 MaterialApp.router로 수정하고 라우터를 적용해줘.
flutter analyze도 실행해줘.
```

### 완료 기준

- [ ] `main.dart`에서 `MaterialApp.router` 사용
- [ ] `routerConfig: appRouter` 설정됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. main.dart가 `MaterialApp.router`를 사용하는지 확인
2. `home:` 속성이 아닌 `routerConfig:` 속성을 사용하는지 확인

---

## 네비게이션 사용법 (참고)

라우팅이 설정되면 다음과 같이 화면 이동이 가능합니다:

```dart
import 'package:go_router/go_router.dart';

// 다른 화면으로 이동 (React의 navigate('/settings'))
context.go('/settings');

// 뒤로 가기
context.pop();

// 현재 스택 위에 새 화면 추가 (push)
context.push('/settings');

// 파라미터와 함께 이동
context.go('/profile/123');

// 이름으로 이동 (라우트에 name 정의 필요)
context.goNamed('settings');
```

### React Router 비교

| React Router                           | go_router               | 설명             |
| -------------------------------------- | ----------------------- | ---------------- |
| `navigate('/path')`                    | `context.go('/path')`   | 이동 (스택 교체) |
| `navigate('/path', { replace: true })` | `context.go('/path')`   | 교체 이동        |
| `navigate(-1)`                         | `context.pop()`         | 뒤로 가기        |
| push to stack                          | `context.push('/path')` | 스택에 추가      |

---

## 진행 현황

```
Phase 5 진행률: [██████████] 100%

TASK-0501 (라우트 상수): [██████████] 100% ✅
TASK-0502 (GoRouter):   [██████████] 100% ✅
TASK-0503 (라우터 적용): [██████████] 100% ✅
```

## 다음 단계

Phase 5 완료 후 → [Phase 6: 상태 관리](./06-state-management.md)로 이동

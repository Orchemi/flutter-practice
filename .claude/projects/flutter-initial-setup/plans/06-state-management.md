# Phase 6: 상태 관리

## 목표

> Riverpod을 설정하여 앱 전역 상태를 관리하는 기반을 구축합니다.

## 왜 Riverpod인가?

### Flutter 상태 관리 비교

| 패키지       | 특징                         | React 비유    | 추천도     |
| ------------ | ---------------------------- | ------------- | ---------- |
| setState     | 내장, 단순                   | useState      | 로컬만     |
| Provider     | 컨텍스트 기반                | Context API   | ⭐⭐       |
| **Riverpod** | Provider 진화형, 컴파일 안전 | Zustand/Jotai | ⭐⭐⭐⭐⭐ |
| Bloc         | 이벤트 기반, 복잡            | Redux         | ⭐⭐⭐     |
| GetX         | 간단하지만 마법적            | -             | ⭐⭐       |

### Riverpod 선택 이유

1. **컴파일 타임 안전성**: 런타임 에러 방지
2. **테스트 용이**: Provider를 쉽게 목킹 가능
3. **코드 생성 지원**: 보일러플레이트 최소화
4. **React와 유사**: hooks_riverpod으로 React Hooks 패턴 사용 가능

### React와 비교

| React         | Riverpod          | 설명           |
| ------------- | ----------------- | -------------- |
| `<Provider>`  | `ProviderScope`   | 전역 상태 루트 |
| `useContext`  | `ref.watch`       | 상태 구독      |
| `useState`    | `StateProvider`   | 단순 상태      |
| Custom Hook   | Provider          | 로직 재사용    |
| Zustand store | `@riverpod` class | 복잡한 상태    |

## 태스크 요약

| ID        | 태스크             | 상태 |
| --------- | ------------------ | ---- |
| TASK-0601 | ProviderScope 설정 | ✅   |
| TASK-0602 | 예제 Provider 생성 | ✅   |

---

## TASK-0601: ProviderScope 설정

### 개요

| 항목          | 내용         |
| ------------- | ------------ |
| **상태**      | ✅ 완료      |
| **선행 조건** | Phase 5 완료 |

### 왜 필요한가요?

React에서 `<Provider store={store}>` 로 전역 상태를 감싸듯,
Flutter Riverpod에서도 `ProviderScope`로 앱을 감싸야 합니다.

### 체크리스트

#### 1단계: main.dart에 ProviderScope 추가

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  // ProviderScope로 앱 감싸기 (React의 <Provider> 역할)
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Practice',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
```

### Claude Code 지침

```markdown
TASK-0601을 진행해줘.
main.dart에 ProviderScope를 추가해줘.
flutter_riverpod 패키지를 import하고 runApp을 ProviderScope로 감싸줘.
```

### 완료 기준

- [x] `flutter_riverpod` import 추가됨
- [x] `runApp`이 `ProviderScope`로 감싸짐
- [x] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. main.dart에 ProviderScope가 올바르게 설정되었는지 확인
2. React의 `<Provider>` 패턴과 비슷한지 확인

---

## TASK-0602: 예제 Provider 생성

### 개요

| 항목          | 내용           |
| ------------- | -------------- |
| **상태**      | ✅ 완료        |
| **선행 조건** | TASK-0601 완료 |

### 왜 필요한가요?

실제 Provider를 만들어보며 Riverpod 사용법을 익힙니다.
riverpod_generator를 사용하면 보일러플레이트 코드가 자동 생성됩니다.

### Riverpod Provider 종류

| Provider           | 용도               | React 비유             |
| ------------------ | ------------------ | ---------------------- |
| `Provider`         | 읽기 전용 값       | useMemo                |
| `StateProvider`    | 단순 상태          | useState               |
| `FutureProvider`   | 비동기 데이터      | useQuery               |
| `StreamProvider`   | 실시간 데이터      | useSubscription        |
| `NotifierProvider` | 복잡한 상태 + 로직 | useReducer + 커스텀 훅 |

### 체크리스트

#### 1단계: 카운터 Provider 생성 (riverpod_generator 사용)

`lib/shared/providers/counter_provider.dart`:

````dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

// 코드 생성을 위한 part 지시문
part 'counter_provider.g.dart';

/// 카운터 상태 관리
///
/// React의 useReducer + 커스텀 훅과 유사
///
/// 사용법:
/// ```dart
/// final count = ref.watch(counterProvider);
/// ref.read(counterProvider.notifier).increment();
/// ```
@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    // 초기값 (React의 initial state)
    return 0;
  }

  /// 증가
  void increment() {
    state = state + 1;
  }

  /// 감소
  void decrement() {
    state = state - 1;
  }

  /// 리셋
  void reset() {
    state = 0;
  }
}
````

#### 2단계: 코드 생성 실행

```bash
dart run build_runner build --delete-conflicting-outputs
```

이 명령어가 `counter_provider.g.dart` 파일을 생성합니다.

#### 3단계: 홈 화면에서 Provider 사용

`lib/features/home/presentation/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/counter_provider.dart';

/// 홈 화면
///
/// ConsumerWidget: Provider를 사용하는 위젯
/// React의 함수 컴포넌트에서 useContext 사용하는 것과 유사
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch: 상태 구독 (값이 변경되면 리빌드)
    // React의 useContext + 자동 리렌더링과 유사
    final count = ref.watch(counterProvider);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Practice'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '안녕하세요! 👋',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Flutter 앱이 정상적으로 실행되었습니다.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // 카운터 섹션
              _buildCounterSection(context, ref, count),

              const Spacer(),

              // 하단 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // ref.read: 일회성 읽기 (이벤트 핸들러에서 사용)
                    ref.read(counterProvider.notifier).reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('카운터가 리셋되었습니다!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('리셋'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 카운터 섹션 위젯
  Widget _buildCounterSection(BuildContext context, WidgetRef ref, int count) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Riverpod 카운터',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          // 카운터 값
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 16),

          // 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 감소 버튼
              IconButton.filled(
                onPressed: () {
                  ref.read(counterProvider.notifier).decrement();
                },
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 24),

              // 증가 버튼
              IconButton.filled(
                onPressed: () {
                  ref.read(counterProvider.notifier).increment();
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

### ref.watch vs ref.read

| 메서드       | 용도                         | React 비유               |
| ------------ | ---------------------------- | ------------------------ |
| `ref.watch`  | 값 구독, 변경 시 리빌드      | useContext + 자동 리렌더 |
| `ref.read`   | 일회성 읽기, 이벤트 핸들러용 | 한 번만 읽기             |
| `ref.listen` | 사이드 이펙트 실행           | useEffect                |

### Claude Code 지침

```markdown
TASK-0602를 진행해줘.

1. lib/shared/providers/counter_provider.dart 파일을 생성해줘.
2. dart run build_runner build --delete-conflicting-outputs 실행해줘.
3. lib/features/home/presentation/screens/home_screen.dart를 업데이트해줘.
   - StatelessWidget → ConsumerWidget으로 변경
   - 카운터 기능 추가
4. flutter analyze 실행해줘.
```

### 완료 기준

- [x] `lib/shared/providers/counter_provider.dart` 생성됨
- [x] `counter_provider.g.dart` 생성됨 (build_runner)
- [x] `home_screen.dart`가 `ConsumerWidget` 사용
- [x] 카운터 기능이 동작함
- [x] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. counter_provider.dart 파일 구조 확인
2. .g.dart 파일이 생성되었는지 확인
3. home_screen.dart에서 ref.watch, ref.read 사용법 확인
4. (선택) `flutter run`으로 앱 실행하여 카운터 동작 확인

---

## Riverpod 심화 (참고)

### FutureProvider 예시 (API 호출)

```dart
@riverpod
Future<List<User>> users(UsersRef ref) async {
  final response = await dio.get('/api/users');
  return response.data.map((json) => User.fromJson(json)).toList();
}

// 위젯에서 사용
final usersAsync = ref.watch(usersProvider);

usersAsync.when(
  data: (users) => ListView(...),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('에러: $error'),
);
```

### Provider 간 의존성

```dart
@riverpod
Future<UserProfile> userProfile(UserProfileRef ref) async {
  // 다른 Provider 구독
  final userId = ref.watch(authProvider).userId;
  final response = await dio.get('/api/users/$userId');
  return UserProfile.fromJson(response.data);
}
```

---

## 진행 현황

```
Phase 6 진행률: [██████████] 100% ✅

TASK-0601 (ProviderScope): [██████████] 100% ✅
TASK-0602 (예제 Provider): [██████████] 100% ✅
```

## 다음 단계

Phase 6 완료 후 → [Phase 7: 첫 화면](./07-first-screen.md)로 이동

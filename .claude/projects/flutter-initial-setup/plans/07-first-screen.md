# Phase 7: 첫 화면

## 목표

> 지금까지 설정한 모든 시스템(테마, 라우팅, 상태 관리)이 잘 동작하는지 확인하고 앱을 실행합니다.

## React와 비교

| React                            | Flutter                     | 설명          |
| -------------------------------- | --------------------------- | ------------- |
| `<div>`                          | `Container`                 | 박스 컨테이너 |
| `<span>`, `<p>`                  | `Text`                      | 텍스트        |
| `<button>`                       | `ElevatedButton`            | 버튼          |
| `<img>`                          | `Image`                     | 이미지        |
| Flexbox `flex-direction: column` | `Column`                    | 세로 배치     |
| Flexbox `flex-direction: row`    | `Row`                       | 가로 배치     |
| `gap`                            | `SizedBox`                  | 간격          |
| `padding`                        | `Padding` 또는 `EdgeInsets` | 패딩          |

## 태스크 요약

| ID        | 태스크            | 상태 |
| --------- | ----------------- | ---- |
| TASK-0701 | 홈 화면 위젯 구현 | ✅   |
| TASK-0702 | 앱 실행 및 테스트 | ✅   |

---

## TASK-0701: 홈 화면 위젯 구현

### 개요

| 항목          | 내용         |
| ------------- | ------------ |
| **상태**      | ✅ 완료      |
| **선행 조건** | Phase 6 완료 |

### 왜 필요한가요?

지금까지 만든 모든 시스템을 통합한 완성된 화면을 구현합니다.

- 테마 시스템 (Phase 4)
- 라우팅 (Phase 5)
- 상태 관리 (Phase 6)

### Flutter 위젯 기초

```dart
// React JSX
<div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
  <h1>제목</h1>
  <p>내용</p>
  <button onClick={handleClick}>클릭</button>
</div>

// Flutter
Column(
  children: [
    Text('제목', style: Theme.of(context).textTheme.headlineLarge),
    SizedBox(height: 16),  // gap 대신 SizedBox
    Text('내용'),
    SizedBox(height: 16),
    ElevatedButton(
      onPressed: handleClick,
      child: Text('클릭'),
    ),
  ],
)
```

### 체크리스트

#### 1단계: 홈 화면 최종 구현

Phase 6에서 만든 `home_screen.dart`에 정보 카드를 추가합니다.

`lib/features/home/presentation/screens/home_screen.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/counter_provider.dart';

/// 홈 화면
///
/// ConsumerWidget: Riverpod Provider를 사용하는 위젯
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Practice'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: 설정 화면으로 이동
              // context.go(AppRoutes.settings);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 헤더 섹션
              Text(
                '안녕하세요! 👋',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Flutter 프로젝트 초기 설정이 완료되었습니다.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // 상태 카드들
              _buildInfoCard(
                context,
                icon: Icons.check_circle,
                title: '환경 설정 완료',
                description: 'Flutter SDK, 패키지, lint 설정이 완료되었습니다.',
                color: AppColors.success,
              ),
              const SizedBox(height: 12),

              _buildInfoCard(
                context,
                icon: Icons.palette,
                title: '테마 시스템',
                description: '색상, 텍스트 스타일, ThemeData가 적용되었습니다.',
                color: AppColors.primary,
              ),
              const SizedBox(height: 12),

              _buildInfoCard(
                context,
                icon: Icons.route,
                title: '라우팅 설정',
                description: 'go_router로 화면 이동 시스템이 구축되었습니다.',
                color: AppColors.secondary,
              ),
              const SizedBox(height: 12),

              _buildInfoCard(
                context,
                icon: Icons.sync,
                title: '상태 관리',
                description: 'Riverpod으로 전역 상태 관리가 가능합니다.',
                color: AppColors.info,
              ),
              const SizedBox(height: 32),

              // 카운터 섹션
              _buildCounterSection(context, ref, count),
              const SizedBox(height: 32),

              // 하단 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(counterProvider.notifier).reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('카운터가 리셋되었습니다!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('카운터 리셋'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 정보 카드 위젯
  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
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
            'Riverpod 카운터 예제',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton.filled(
                onPressed: () {
                  ref.read(counterProvider.notifier).decrement();
                },
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 24),
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

### Claude Code 지침

```markdown
TASK-0701을 진행해줘.
lib/features/home/presentation/screens/home_screen.dart를 위 내용으로 업데이트해줘.
flutter analyze도 실행해줘.
```

### 완료 기준

- [x] `home_screen.dart` 업데이트 완료
- [x] 테마 시스템 사용 (`Theme.of(context)`)
- [x] 색상 상수 사용 (`AppColors`)
- [x] 상태 관리 사용 (`ref.watch`, `ref.read`)
- [x] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. 코드 구조가 React 컴포넌트와 비슷한지 확인
2. `_buildInfoCard` 같은 헬퍼 메서드 패턴 이해
3. `ConsumerWidget`과 `ref` 사용법 확인

---

## TASK-0702: 앱 실행 및 테스트

### 개요

| 항목          | 내용           |
| ------------- | -------------- |
| **상태**      | ✅ 완료        |
| **선행 조건** | TASK-0701 완료 |

### 왜 필요한가요?

지금까지 만든 모든 설정이 제대로 작동하는지 실제로 확인합니다.
React에서 `npm run dev` 후 브라우저에서 확인하는 것과 같습니다.

### 체크리스트

#### 1단계: 코드 품질 검사

```bash
# 정적 분석
flutter analyze

# 코드 포맷팅
dart format .
```

#### 2단계: 앱 실행

```bash
# 사용 가능한 디바이스 확인
flutter devices

# 앱 실행 (디바이스 선택)
flutter run

# 특정 디바이스에서 실행
flutter run -d chrome      # 웹 브라우저
flutter run -d macos       # macOS 앱
flutter run -d <device_id> # 특정 디바이스
```

#### 3단계: 확인 사항

- [ ] 앱이 에러 없이 실행되는가?
- [ ] "안녕하세요! 👋" 텍스트가 보이는가?
- [ ] 4개의 정보 카드(환경설정, 테마, 라우팅, 상태관리)가 표시되는가?
- [ ] 카운터 +/- 버튼이 동작하는가?
- [ ] "카운터 리셋" 버튼 클릭 시 스낵바가 나타나는가?
- [ ] AppBar가 정상적으로 표시되는가?

### Claude Code 지침

```markdown
TASK-0702를 진행해줘.
flutter analyze와 dart format을 실행하고,
flutter devices로 사용 가능한 디바이스 목록을 보여줘.
```

### 완료 기준

- [x] `flutter analyze` 에러 없음
- [x] `dart format .` 완료
- [x] 앱 실행 가능 상태

### 사용자 검수 포인트

1. `flutter analyze` 결과 확인
2. 사용 가능한 디바이스 목록 확인
3. **직접 `flutter run` 실행하여 앱 확인** (사용자가 직접)

---

## Hot Reload 사용법 (참고)

앱 실행 중 코드를 수정하면:

| 키  | 동작        | 설명                         |
| --- | ----------- | ---------------------------- |
| `r` | Hot Reload  | 상태 유지하며 UI 갱신 (빠름) |
| `R` | Hot Restart | 앱 재시작 (상태 초기화)      |
| `q` | 종료        | 앱 종료                      |

React의 Fast Refresh와 비슷하지만, Flutter의 Hot Reload가 더 빠릅니다!

---

## 프로젝트 완료 🎉

### 최종 프로젝트 구조

```
lib/
├── main.dart                          # 앱 진입점
│
├── core/                              # 앱 전역 공통 코드
│   ├── constants/
│   │   ├── app_colors.dart            # 색상 팔레트
│   │   └── app_text_styles.dart       # 텍스트 스타일
│   ├── theme/
│   │   └── app_theme.dart             # ThemeData 정의
│   ├── router/
│   │   ├── app_routes.dart            # 라우트 경로 상수
│   │   └── app_router.dart            # GoRouter 설정
│   ├── utils/
│   ├── extensions/
│   └── network/
│
├── features/                          # 기능별 모듈
│   └── home/
│       ├── presentation/
│       │   ├── screens/
│       │   │   └── home_screen.dart   # 홈 화면
│       │   ├── widgets/
│       │   └── providers/
│       ├── domain/
│       │   └── models/
│       └── data/
│           ├── repositories/
│           └── datasources/
│
└── shared/                            # 여러 기능에서 공유
    ├── widgets/
    ├── providers/
    │   ├── counter_provider.dart      # 카운터 Provider
    │   └── counter_provider.g.dart    # 생성된 파일
    └── models/
        ├── user.dart                  # User 모델 (freezed)
        ├── user.freezed.dart          # 생성된 파일
        └── user.g.dart                # 생성된 파일
```

### 구축된 시스템 요약

| 시스템      | 패키지            | 파일                    |
| ----------- | ----------------- | ----------------------- |
| 테마        | Material Design 3 | `app_theme.dart`        |
| 라우팅      | go_router         | `app_router.dart`       |
| 상태 관리   | Riverpod          | `counter_provider.dart` |
| 데이터 모델 | freezed           | `user.dart`             |
| HTTP        | dio               | (추후 설정)             |
| 코드 생성   | build_runner      | `build.yaml`            |

### 다음 학습 추천

1. **API 연동**: Dio 패키지로 실제 API 호출
2. **로컬 저장소**: SharedPreferences, Hive
3. **폼 처리**: flutter_form_builder
4. **애니메이션**: Flutter 내장 애니메이션
5. **테스트**: 단위 테스트, 위젯 테스트

### 유용한 자료

- [Flutter 공식 문서](https://docs.flutter.dev/)
- [Riverpod 공식 문서](https://riverpod.dev/)
- [go_router 가이드](https://pub.dev/packages/go_router)
- [freezed 가이드](https://pub.dev/packages/freezed)

---

## 진행 현황

```
Phase 7 진행률: [██████████] 100% ✅

TASK-0701 (홈 화면 구현): [██████████] 100% ✅
TASK-0702 (앱 실행):     [██████████] 100% ✅
```

---

축하합니다! 🎉
Flutter 프로젝트 초기 설정이 완료되었습니다!
이제 본격적인 앱 개발을 시작할 수 있습니다.

# Phase 4: 테마 설정

## 목표

> 앱 전체에서 일관된 디자인을 위한 테마 시스템을 구축합니다.

## React와 비교

| React | Flutter | 설명 |
|-------|---------|------|
| CSS variables / Theme Provider | `ThemeData` | 전역 테마 |
| `colors.primary` | `Theme.of(context).primaryColor` | 색상 접근 |
| styled-components theme | `ColorScheme` | 색상 팔레트 |
| Typography system | `TextTheme` | 텍스트 스타일 |

## 태스크 요약

| ID | 태스크 | 상태 |
|----|--------|------|
| TASK-0401 | 색상 팔레트 정의 | 🔲 |
| TASK-0402 | 텍스트 스타일 정의 | 🔲 |
| TASK-0403 | ThemeData 구성 | 🔲 |

---

## TASK-0401: 색상 팔레트 정의

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | 🔲 진행 전 |
| **선행 조건** | Phase 3 완료 |

### 왜 필요한가요?

CSS에서 `:root { --primary: #3B82F6; }` 같이 색상 변수를 정의하듯,
Flutter에서도 색상을 한 곳에서 관리하면 일관된 디자인을 유지할 수 있습니다.

### 체크리스트

#### 1단계: 색상 상수 파일 생성

`lib/core/constants/app_colors.dart`:

```dart
import 'package:flutter/material.dart';

/// 앱에서 사용하는 색상 정의
///
/// 사용법:
/// ```dart
/// Container(color: AppColors.primary)
/// ```
abstract class AppColors {
  // Primary 색상 (브랜드 메인 컬러)
  static const Color primary = Color(0xFF3B82F6);      // blue-500
  static const Color primaryLight = Color(0xFF60A5FA); // blue-400
  static const Color primaryDark = Color(0xFF2563EB);  // blue-600

  // Secondary 색상 (보조 컬러)
  static const Color secondary = Color(0xFF8B5CF6);    // violet-500

  // Neutral 색상 (회색 계열)
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Semantic 색상 (의미를 가진 색상)
  static const Color success = Color(0xFF22C55E);      // green-500
  static const Color warning = Color(0xFFF59E0B);      // amber-500
  static const Color error = Color(0xFFEF4444);        // red-500
  static const Color info = Color(0xFF3B82F6);         // blue-500

  // 배경색
  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFF9FAFB);

  // 텍스트 색상
  static const Color textPrimary = Color(0xFF111827);   // gray-900
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textDisabled = Color(0xFF9CA3AF);  // gray-400
}
```

### Claude Code 지침

```markdown
TASK-0401을 진행해줘.
lib/core/constants/app_colors.dart 파일을 생성하고,
위 내용으로 색상 팔레트를 정의해줘.
```

### 완료 기준

- [ ] `lib/core/constants/app_colors.dart` 파일 생성됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. 파일이 올바른 위치에 생성되었는지 확인
2. 색상 값들이 Tailwind CSS와 비슷한 체계인지 확인 (익숙함)

---

## TASK-0402: 텍스트 스타일 정의

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | 🔲 진행 전 |
| **선행 조건** | TASK-0401 완료 |

### 왜 필요한가요?

CSS에서 `.text-xl { font-size: 1.25rem; }` 같이 텍스트 스타일을 정의하듯,
Flutter에서도 텍스트 스타일을 체계적으로 관리합니다.

### 체크리스트

#### 1단계: 텍스트 스타일 파일 생성

`lib/core/constants/app_text_styles.dart`:

```dart
import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 앱에서 사용하는 텍스트 스타일 정의
///
/// 사용법:
/// ```dart
/// Text('제목', style: AppTextStyles.headlineLarge)
/// ```
abstract class AppTextStyles {
  // Headline (제목)
  static const TextStyle headlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.25,
  );

  // Title (소제목)
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Body (본문)
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.5,
  );

  // Label (레이블, 버튼 텍스트)
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.4,
  );
}
```

### Claude Code 지침

```markdown
TASK-0402를 진행해줘.
lib/core/constants/app_text_styles.dart 파일을 생성해줘.
```

### 완료 기준

- [ ] `lib/core/constants/app_text_styles.dart` 파일 생성됨
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. 텍스트 크기 체계가 이해하기 쉬운지 확인
2. headline, title, body, label 구분이 명확한지 확인

---

## TASK-0403: ThemeData 구성

### 개요

| 항목 | 내용 |
|------|------|
| **상태** | 🔲 진행 전 |
| **선행 조건** | TASK-0402 완료 |

### 왜 필요한가요?

React의 ThemeProvider처럼, Flutter의 `ThemeData`를 통해
앱 전체에 테마를 적용합니다.

### 체크리스트

#### 1단계: 테마 파일 생성

`lib/core/theme/app_theme.dart`:

```dart
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

/// 앱 테마 정의
class AppTheme {
  // Light 테마
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // 색상 스키마
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        error: AppColors.error,
        surface: AppColors.surface,
      ),

      // 배경색
      scaffoldBackgroundColor: AppColors.background,

      // AppBar 테마
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: true,
      ),

      // 텍스트 테마
      textTheme: const TextTheme(
        headlineLarge: AppTextStyles.headlineLarge,
        headlineMedium: AppTextStyles.headlineMedium,
        headlineSmall: AppTextStyles.headlineSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // 버튼 테마
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      // 입력 필드 테마
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  // Dark 테마 (나중에 구현)
  static ThemeData get dark {
    return ThemeData.dark().copyWith(
      useMaterial3: true,
      // TODO: 다크 테마 구현
    );
  }
}
```

#### 2단계: main.dart에 테마 적용

```dart
import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Practice',
      theme: AppTheme.light,        // 라이트 테마 적용
      darkTheme: AppTheme.dark,     // 다크 테마 (시스템 설정 따름)
      home: const Scaffold(
        body: Center(
          child: Text('Hello, Flutter!'),
        ),
      ),
    );
  }
}
```

### Claude Code 지침

```markdown
TASK-0403을 진행해줘.
lib/core/theme/app_theme.dart 파일을 생성하고,
main.dart에 테마를 적용해줘.
```

### 완료 기준

- [ ] `lib/core/theme/app_theme.dart` 파일 생성됨
- [ ] `main.dart`에서 `AppTheme.light` 사용
- [ ] `flutter analyze` 에러 없음

### 사용자 검수 포인트

1. 테마 파일 구조 확인
2. main.dart에서 테마가 적용되었는지 확인
3. (선택) 앱 실행해서 스타일이 적용되는지 확인

---

## 진행 현황

```
Phase 4 진행률: [░░░░░░░░░░] 0%

TASK-0401 (색상 팔레트):   [░░░░░░░░░░] 0%
TASK-0402 (텍스트 스타일): [░░░░░░░░░░] 0%
TASK-0403 (ThemeData):    [░░░░░░░░░░] 0%
```

## 다음 단계

Phase 4 완료 후 → [Phase 5: 라우팅](./05-routing.md)로 이동

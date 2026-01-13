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

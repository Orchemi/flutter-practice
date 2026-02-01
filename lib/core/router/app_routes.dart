/// 앱에서 사용하는 라우트 경로 상수
abstract class AppRoutes {
  /// 허브 화면 (Step 목록)
  static const String hub = '/';

  /// Step 상세 화면
  static const String step = '/step/:id';

  /// Step 경로 생성 헬퍼
  static String stepWithId(int id) => '/step/$id';
}

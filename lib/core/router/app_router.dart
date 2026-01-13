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

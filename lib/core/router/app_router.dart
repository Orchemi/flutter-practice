import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app_routes.dart';
import '../../features/hub/presentation/screens/hub_screen.dart';
import '../../features/step1_basics/presentation/screens/basics_screen.dart';
import '../../features/step2_supabase/presentation/screens/supabase_screen.dart';
import '../../features/step3_advanced/presentation/screens/advanced_screen.dart';

/// 앱 라우터 설정
final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.hub,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: AppRoutes.hub,
      name: 'hub',
      builder: (context, state) => const HubScreen(),
    ),
    GoRoute(
      path: AppRoutes.step,
      name: 'step',
      builder: (context, state) {
        final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 1;
        return switch (id) {
          1 => const BasicsScreen(),
          2 => const SupabaseScreen(),
          3 => const AdvancedScreen(),
          _ => const BasicsScreen(),
        };
      },
    ),
  ],
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
            onPressed: () => context.go(AppRoutes.hub),
            child: const Text('홈으로 이동'),
          ),
        ],
      ),
    ),
  ),
);

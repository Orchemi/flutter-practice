import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/supabase_config.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/auth_state_provider.dart';
import 'auth_dashboard_view.dart';
import 'auth_login_view.dart';

/// Auth 탭 컨테이너 - 인증 상태에 따라 로그인/대시보드 전환
class AuthTab extends ConsumerWidget {
  const AuthTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Supabase 미설정 시 안내
    if (!SupabaseConfig.isConfigured) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber, size: 48, color: AppColors.gray400),
              const SizedBox(height: 16),
              Text(
                'Supabase 설정 필요',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Text(
                '--dart-define으로 SUPABASE_URL과\nSUPABASE_ANON_KEY를 전달해주세요.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    final authState = ref.watch(authStateProvider);

    return authState.when(
      data: (state) {
        final user = state.session?.user;
        if (user != null) {
          return AuthDashboardView(user: user);
        }
        return const AuthLoginView();
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: AppColors.error),
            const SizedBox(height: 16),
            Text('오류: $error'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/auth_actions_provider.dart';

/// 로그인 후 유저 정보/로그아웃 대시보드
class AuthDashboardView extends ConsumerWidget {
  final User user;

  const AuthDashboardView({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authActionsProvider);
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const SizedBox(height: 32),

          // 프로필 아바타
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.secondary.withValues(alpha: 0.15),
            backgroundImage: user.userMetadata?['avatar_url'] != null
                ? NetworkImage(user.userMetadata!['avatar_url'] as String)
                : null,
            child: user.userMetadata?['avatar_url'] == null
                ? const Icon(Icons.person, size: 40, color: AppColors.secondary)
                : null,
          ),
          const SizedBox(height: 16),

          // 유저 이름
          Text(
            user.userMetadata?['full_name'] as String? ??
                user.userMetadata?['name'] as String? ??
                '사용자',
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: 4),

          // 이메일
          Text(
            user.email ?? '',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),

          // 유저 정보 카드
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.gray50,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('계정 정보', style: textTheme.titleMedium),
                const SizedBox(height: 16),
                _InfoRow(label: 'ID', value: user.id),
                const SizedBox(height: 8),
                _InfoRow(
                  label: 'Provider',
                  value: user.appMetadata['provider'] as String? ?? '-',
                ),
                const SizedBox(height: 8),
                _InfoRow(
                  label: '생성일',
                  value: user.createdAt.substring(0, 10),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // 로그아웃 버튼
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: isLoading
                  ? null
                  : () => _signOut(context, ref),
              icon: const Icon(Icons.logout),
              label: const Text('로그아웃'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authActionsProvider.notifier).signOut();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('로그아웃 실패: $e')),
        );
      }
    }
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ],
    );
  }
}

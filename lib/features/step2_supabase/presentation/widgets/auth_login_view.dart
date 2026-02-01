import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/auth_actions_provider.dart';

/// 소셜 로그인 UI
class AuthLoginView extends ConsumerWidget {
  const AuthLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authActionsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 64, color: AppColors.secondary),
            const SizedBox(height: 24),
            Text('Supabase Auth', style: textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              '소셜 계정으로 로그인하세요',
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 40),

            // Google 로그인 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: isLoading
                    ? null
                    : () => _signInWithGoogle(context, ref),
                icon: const Icon(Icons.g_mobiledata, size: 24),
                label: const Text('Google로 로그인'),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            // Apple 로그인 버튼 (iOS만)
            if (Platform.isIOS) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () => _signInWithApple(context, ref),
                  icon: const Icon(Icons.apple, size: 24),
                  label: const Text('Apple로 로그인'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],

            if (isLoading) ...[
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authActionsProvider.notifier).signInWithGoogle();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google 로그인 실패: $e')),
        );
      }
    }
  }

  Future<void> _signInWithApple(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(authActionsProvider.notifier).signInWithApple();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Apple 로그인 실패: $e')),
        );
      }
    }
  }
}

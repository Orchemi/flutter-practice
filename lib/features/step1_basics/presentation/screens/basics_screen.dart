import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/counter_provider.dart';

/// Step 1: 기초 - 위젯, 상태관리, 테마 시스템
class BasicsScreen extends ConsumerWidget {
  const BasicsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterProvider);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 1: 기초')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('안녕하세요! 👋', style: textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                'Flutter 프로젝트 초기 설정이 완료되었습니다.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

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

              _buildCounterSection(context, ref, count),
              const SizedBox(height: 32),

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
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(description, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

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

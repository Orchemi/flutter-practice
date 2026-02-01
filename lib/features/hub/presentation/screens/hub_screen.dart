import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/router/app_routes.dart';

/// Step 데이터 모델
class _StepItem {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isReady;

  const _StepItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isReady = false,
  });
}

/// 허브 화면 - Step 목록을 보여주는 메인 화면
class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  static const List<_StepItem> _steps = [
    _StepItem(
      id: 1,
      title: 'Step 1: 기초',
      description: '위젯, 상태관리, 테마 시스템',
      icon: Icons.widgets,
      color: AppColors.primary,
      isReady: true,
    ),
    _StepItem(
      id: 2,
      title: 'Step 2: Supabase',
      description: '스토리지, 데이터베이스, 인증',
      icon: Icons.cloud,
      color: AppColors.secondary,
      isReady: true,
    ),
    _StepItem(
      id: 3,
      title: 'Step 3: 고급 기능',
      description: '애니메이션, 네이티브 연동, 배포',
      icon: Icons.rocket_launch,
      color: AppColors.success,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Playground')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('플레이그라운드', style: textTheme.headlineLarge),
              const SizedBox(height: 8),
              Text(
                'Step별로 Flutter 기능을 실험해보세요.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              ...List.generate(_steps.length, (index) {
                final step = _steps[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < _steps.length - 1 ? 16 : 0,
                  ),
                  child: _StepCard(step: step),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

/// Step 카드 위젯
class _StepCard extends StatelessWidget {
  final _StepItem step;

  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => context.go(AppRoutes.stepWithId(step.id)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: step.color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: step.color.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: step.color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(step.icon, color: step.color, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.title, style: textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text(
                    step.description,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (step.isReady)
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: step.color,
              )
            else
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.gray200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '준비 중',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

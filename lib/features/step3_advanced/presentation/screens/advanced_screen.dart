import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Step 3: 고급 기능 - 애니메이션, 네이티브 연동, 배포
class AdvancedScreen extends StatelessWidget {
  const AdvancedScreen({super.key});

  static const List<_FeatureItem> _features = [
    _FeatureItem(icon: Icons.animation, title: 'Animation', description: '암시적/명시적 애니메이션'),
    _FeatureItem(icon: Icons.phone_android, title: 'Native 연동', description: 'Platform Channel'),
    _FeatureItem(icon: Icons.notifications, title: 'Push 알림', description: 'FCM 연동'),
    _FeatureItem(icon: Icons.publish, title: '스토어 배포', description: 'App Store / Google Play'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 3: 고급 기능')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.success.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.construction,
                      size: 48,
                      color: AppColors.success,
                    ),
                    const SizedBox(height: 16),
                    Text('준비 중', style: textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(
                      '고급 기능이 곧 추가됩니다.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text('구현 예정 기능', style: textTheme.titleMedium),
              const SizedBox(height: 16),
              ..._features.map(
                (feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _FeatureCard(feature: feature),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _FeatureCard extends StatelessWidget {
  final _FeatureItem feature;

  const _FeatureCard({required this.feature});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(feature.icon, color: AppColors.gray400, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  feature.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Step 2: Supabase - 스토리지, 데이터베이스, 인증
class SupabaseScreen extends StatelessWidget {
  const SupabaseScreen({super.key});

  static const List<_FeatureItem> _features = [
    _FeatureItem(icon: Icons.storage, title: 'Storage', description: '파일 업로드/다운로드'),
    _FeatureItem(icon: Icons.table_chart, title: 'Database', description: 'CRUD 작업'),
    _FeatureItem(icon: Icons.lock, title: 'Auth', description: '회원가입/로그인'),
    _FeatureItem(icon: Icons.bolt, title: 'Realtime', description: '실시간 데이터 구독'),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Step 2: Supabase')),
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
                  color: AppColors.secondary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.secondary.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.construction,
                      size: 48,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(height: 16),
                    Text('준비 중', style: textTheme.headlineSmall),
                    const SizedBox(height: 8),
                    Text(
                      'Supabase 연동 기능이 곧 추가됩니다.',
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

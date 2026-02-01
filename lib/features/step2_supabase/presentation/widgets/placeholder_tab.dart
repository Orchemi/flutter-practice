import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// 미구현 탭 placeholder
class PlaceholderTab extends StatelessWidget {
  final String title;
  final IconData icon;

  const PlaceholderTab({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: AppColors.gray400),
          const SizedBox(height: 16),
          Text(title, style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            '준비 중입니다',
            style: textTheme.bodyMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

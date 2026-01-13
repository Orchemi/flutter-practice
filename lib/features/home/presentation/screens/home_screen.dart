import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../shared/providers/counter_provider.dart';

/// 홈 화면
///
/// ConsumerWidget: Provider를 사용하는 위젯
/// React의 함수 컴포넌트에서 useContext 사용하는 것과 유사
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.watch: 상태 구독 (값이 변경되면 리빌드)
    // React의 useContext + 자동 리렌더링과 유사
    final count = ref.watch(counterProvider);

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Practice'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '안녕하세요! 👋',
                style: textTheme.headlineLarge,
              ),
              const SizedBox(height: 8),
              Text(
                'Flutter 앱이 정상적으로 실행되었습니다.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // 카운터 섹션
              _buildCounterSection(context, ref, count),

              const Spacer(),

              // 하단 버튼
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // ref.read: 일회성 읽기 (이벤트 핸들러에서 사용)
                    ref.read(counterProvider.notifier).reset();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('카운터가 리셋되었습니다!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: const Text('리셋'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 카운터 섹션 위젯
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
            'Riverpod 카운터',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 16),

          // 카운터 값
          Text(
            '$count',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 16),

          // 버튼들
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 감소 버튼
              IconButton.filled(
                onPressed: () {
                  ref.read(counterProvider.notifier).decrement();
                },
                icon: const Icon(Icons.remove),
              ),
              const SizedBox(width: 24),

              // 증가 버튼
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

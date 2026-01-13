import 'package:riverpod_annotation/riverpod_annotation.dart';

// 코드 생성을 위한 part 지시문
part 'counter_provider.g.dart';

/// 카운터 상태 관리
///
/// React의 useReducer + 커스텀 훅과 유사
///
/// 사용법:
/// ```dart
/// final count = ref.watch(counterProvider);
/// ref.read(counterProvider.notifier).increment();
/// ```
@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    // 초기값 (React의 initial state)
    return 0;
  }

  /// 증가
  void increment() {
    state = state + 1;
  }

  /// 감소
  void decrement() {
    state = state - 1;
  }

  /// 리셋
  void reset() {
    state = 0;
  }
}

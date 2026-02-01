import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_provider.dart';

part 'auth_state_provider.g.dart';

/// 인증 상태 Stream Provider
///
/// Supabase auth state 변화를 실시간으로 구독
@riverpod
Stream<AuthState> authState(Ref ref) {
  final client = ref.watch(supabaseClientProvider);
  if (client == null) return const Stream.empty();
  return client.auth.onAuthStateChange;
}

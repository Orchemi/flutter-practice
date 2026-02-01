import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/supabase_config.dart';

part 'supabase_provider.g.dart';

/// Supabase 클라이언트 Provider
///
/// Supabase가 초기화되지 않았으면 null 반환
@riverpod
SupabaseClient? supabaseClient(Ref ref) {
  if (!SupabaseConfig.isConfigured) return null;
  return Supabase.instance.client;
}

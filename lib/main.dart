import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/config/supabase_config.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Supabase 초기화 (dart-define 값이 있을 때만)
  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
    );
  }

  // ProviderScope로 앱 감싸기 (React의 <Provider> 역할)
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp → MaterialApp.router로 변경!
    return MaterialApp.router(
      title: 'Flutter Practice',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // 라우터 설정 연결
      routerConfig: appRouter,
    );
  }
}

import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

void main() {
  runApp(const MyApp());
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

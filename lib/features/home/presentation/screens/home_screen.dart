import 'package:flutter/material.dart';

/// 홈 화면
///
/// 앱의 메인 화면으로, 라우팅 설정 후 초기 화면으로 표시됩니다.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Practice'),
      ),
      body: const Center(
        child: Text('홈 화면'),
      ),
    );
  }
}

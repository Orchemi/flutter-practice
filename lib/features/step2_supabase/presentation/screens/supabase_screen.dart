import 'package:flutter/material.dart';
import '../widgets/auth_tab.dart';
import '../widgets/placeholder_tab.dart';

/// Step 2: Supabase - 탭 기반 기능 탐색
class SupabaseScreen extends StatelessWidget {
  const SupabaseScreen({super.key});

  static const List<Tab> _tabs = [
    Tab(icon: Icon(Icons.lock), text: 'Auth'),
    Tab(icon: Icon(Icons.storage), text: 'Storage'),
    Tab(icon: Icon(Icons.table_chart), text: 'DB'),
    Tab(icon: Icon(Icons.bolt), text: 'Realtime'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Step 2: Supabase'),
          bottom: const TabBar(tabs: _tabs),
        ),
        body: const TabBarView(
          children: [
            AuthTab(),
            PlaceholderTab(title: 'Storage', icon: Icons.storage),
            PlaceholderTab(title: 'Database', icon: Icons.table_chart),
            PlaceholderTab(title: 'Realtime', icon: Icons.bolt),
          ],
        ),
      ),
    );
  }
}

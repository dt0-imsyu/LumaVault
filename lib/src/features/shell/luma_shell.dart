import 'package:flutter/material.dart';

import '../../data/auth_service.dart';
import '../../data/finance_api.dart';
import '../../data/finance_repository.dart';
import '../analytics/analytics_screen.dart';
import '../auth/login_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../transactions/transactions_screen.dart';

class LumaShell extends StatefulWidget {
  const LumaShell({super.key, required this.authService, required this.session});

  final AuthService authService;
  final AuthSession session;

  @override
  State<LumaShell> createState() => _LumaShellState();
}

class _LumaShellState extends State<LumaShell> {
  final _repository = FinanceRepository(FinanceApi());
  late Future<FinanceSnapshot> _snapshot = _repository.loadSnapshot();
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FinanceSnapshot>(
      future: _snapshot,
      builder: (context, state) {
        final snapshot = state.data;
        final pages = [
          DashboardScreen(snapshot: snapshot, loading: state.connectionState != ConnectionState.done, userName: widget.session.userName, onLogout: _signOut),
          AnalyticsScreen(snapshot: snapshot),
          TransactionsScreen(snapshot: snapshot),
        ];
        return Scaffold(
          body: pages[_tab],
          bottomNavigationBar: NavigationBar(
            selectedIndex: _tab,
            onDestinationSelected: (value) => setState(() => _tab = value),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: 'Обзор'),
              NavigationDestination(icon: Icon(Icons.insights_outlined), selectedIcon: Icon(Icons.insights), label: 'Аналитика'),
              NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label: 'Операции'),
            ],
          ),
          floatingActionButton: FloatingActionButton.small(
            onPressed: () => setState(() => _snapshot = _repository.loadSnapshot()),
            child: const Icon(Icons.sync),
          ),
        );
      },
    );
  }

  Future<void> _signOut() async {
    await widget.authService.signOut();
    if (!mounted) return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen(authService: widget.authService)));
  }
}

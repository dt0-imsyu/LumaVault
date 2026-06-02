import 'package:flutter/material.dart';

import '../../data/finance_repository.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key, required this.snapshot});

  final FinanceSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final transactions = snapshot?.transactions ?? const <TransactionItem>[];
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 96),
        children: [
          const Text('Операции', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text('Каждая операция получает риск-оценку и категорию для бюджета.', style: TextStyle(color: Color(0xFFC3D8DB))),
          const SizedBox(height: 18),
          for (final item in transactions)
            Card(
              child: ListTile(
                leading: CircleAvatar(backgroundColor: const Color(0xFF17373E), child: Icon(_iconFor(item.category), color: const Color(0xFF22E0B8))),
                title: Text(item.title),
                subtitle: Text('${item.category} · риск ${item.risk}%'),
                trailing: Text('${item.amount} ₽', style: TextStyle(fontWeight: FontWeight.w900, color: item.amount > 0 ? const Color(0xFF22E0B8) : null)),
              ),
            ),
        ],
      ),
    );
  }

  IconData _iconFor(String category) {
    return switch (category) {
      'Подписки' => Icons.design_services,
      'Доход' => Icons.arrow_downward,
      'Офис' => Icons.business_center,
      _ => Icons.cloud_outlined,
    };
  }
}

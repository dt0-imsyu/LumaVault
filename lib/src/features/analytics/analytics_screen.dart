import 'package:flutter/material.dart';

import '../../data/finance_repository.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key, required this.snapshot});

  final FinanceSnapshot? snapshot;

  @override
  Widget build(BuildContext context) {
    final budgets = snapshot?.budgets ?? const <BudgetBucket>[];
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 96),
        children: [
          const Text('AI-анализ бюджета', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text('Риск-скоринг операций и лимиты строятся из локального профиля и live-курсов валют.', style: TextStyle(color: Color(0xFFC3D8DB))),
          const SizedBox(height: 22),
          Container(
            height: 220,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(color: const Color(0xFF0E252B), borderRadius: BorderRadius.circular(22)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [34, 76, 48, 112, 86, 138, 96]
                  .map((height) => Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: height.toDouble(),
                          decoration: BoxDecoration(
                            color: height > 100 ? const Color(0xFFFFC857) : const Color(0xFF22E0B8),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          const SizedBox(height: 22),
          for (final budget in budgets) _BudgetRow(budget),
        ],
      ),
    );
  }
}

class _BudgetRow extends StatelessWidget {
  const _BudgetRow(this.budget);

  final BudgetBucket budget;

  @override
  Widget build(BuildContext context) {
    final progress = budget.spent / budget.limit;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(budget.title, style: const TextStyle(fontWeight: FontWeight.w800)),
            Text('${budget.spent}/${budget.limit} ₽'),
          ]),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: progress, color: Color(budget.color), backgroundColor: const Color(0xFF203A40)),
        ]),
      ),
    );
  }
}

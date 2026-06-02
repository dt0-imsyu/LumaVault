import 'finance_api.dart';

class TransactionItem {
  const TransactionItem(this.title, this.category, this.amount, this.risk);

  final String title;
  final String category;
  final int amount;
  final int risk;
}

class BudgetBucket {
  const BudgetBucket(this.title, this.spent, this.limit, this.color);

  final String title;
  final int spent;
  final int limit;
  final int color;
}

class FinanceSnapshot {
  const FinanceSnapshot({
    required this.balance,
    required this.cashback,
    required this.goalProgress,
    required this.rates,
    required this.transactions,
    required this.budgets,
  });

  final int balance;
  final int cashback;
  final double goalProgress;
  final List<RateQuote> rates;
  final List<TransactionItem> transactions;
  final List<BudgetBucket> budgets;
}

class FinanceRepository {
  FinanceRepository(this._api);

  final FinanceApi _api;

  Future<FinanceSnapshot> loadSnapshot() async {
    final rates = await _api.loadRates();
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return FinanceSnapshot(
      balance: 482950,
      cashback: 8240,
      goalProgress: 0.72,
      rates: rates,
      transactions: const [
        TransactionItem('Figma Professional', 'Подписки', -2990, 18),
        TransactionItem('Пополнение счета', 'Доход', 85000, 4),
        TransactionItem('Workspace One', 'Офис', -14500, 32),
        TransactionItem('Cloud GPU', 'Инфраструктура', -7400, 44),
      ],
      budgets: const [
        BudgetBucket('Подписки', 18400, 24000, 0xFF22E0B8),
        BudgetBucket('Работа', 42700, 60000, 0xFF3A7DFF),
        BudgetBucket('Дом', 31800, 52000, 0xFFFFC857),
      ],
    );
  }
}

import 'package:flutter/material.dart';

import '../../data/finance_repository.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({
    super.key,
    required this.snapshot,
    required this.loading,
    required this.userName,
    required this.onLogout,
  });

  final FinanceSnapshot? snapshot;
  final bool loading;
  final String userName;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final data = snapshot;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 96),
        children: [
          Row(
            children: [
              const CircleAvatar(backgroundColor: Color(0xFF22E0B8), child: Text('D', style: TextStyle(color: Color(0xFF071318)))),
              const SizedBox(width: 12),
              Expanded(child: Text('Доброе утро, $userName', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800))),
              IconButton.filledTonal(onPressed: onLogout, icon: const Icon(Icons.logout)),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              gradient: const LinearGradient(colors: [Color(0xFF22E0B8), Color(0xFF3A7DFF)]),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Основной счет', style: TextStyle(color: Color(0xFF071318), fontWeight: FontWeight.w800)),
              const SizedBox(height: 18),
              Text(data == null ? 'Загрузка...' : '${data.balance} ₽', style: const TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Color(0xFF071318))),
              const SizedBox(height: 20),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('LUMA · 4088', style: TextStyle(color: Color(0xFF071318))),
                Icon(Icons.contactless, color: Color(0xFF071318)),
              ]),
            ]),
          ),
          const SizedBox(height: 16),
          if (loading) const LinearProgressIndicator(),
          if (data != null) ...[
            const SizedBox(height: 18),
            Row(children: [
              _StatCard('Кэшбэк', '${data.cashback} ₽', Icons.savings_outlined),
              const SizedBox(width: 12),
              _StatCard('Цель', '${(data.goalProgress * 100).round()}%', Icons.flag_outlined),
            ]),
            const SizedBox(height: 22),
            const Text('Live-курсы', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
            const SizedBox(height: 10),
            SizedBox(
              height: 94,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: data.rates.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final rate = data.rates[index];
                  return Container(
                    width: 142,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: const Color(0xFF0E252B), borderRadius: BorderRadius.circular(18)),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(rate.symbol, style: const TextStyle(color: Color(0xFFC3D8DB))),
                      const Spacer(),
                      Text(rate.value.toStringAsFixed(rate.value > 20 ? 1 : 3), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                    ]),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard(this.title, this.value, this.icon);

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon, color: const Color(0xFF22E0B8)),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(color: Color(0xFFC3D8DB))),
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          ]),
        ),
      ),
    );
  }
}

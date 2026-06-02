import 'dart:convert';

import 'package:http/http.dart' as http;

class RateQuote {
  const RateQuote({required this.symbol, required this.value, required this.delta});

  final String symbol;
  final double value;
  final double delta;
}

class FinanceApi {
  FinanceApi({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<List<RateQuote>> loadRates() async {
    final uri = Uri.parse('https://api.frankfurter.app/latest?from=EUR&to=USD,GBP,JPY');
    try {
      final response = await _client.get(uri).timeout(const Duration(seconds: 4));
      if (response.statusCode != 200) throw StateError('HTTP ${response.statusCode}');
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final rates = json['rates'] as Map<String, dynamic>;
      return [
        RateQuote(symbol: 'EUR/USD', value: (rates['USD'] as num).toDouble(), delta: 0.21),
        RateQuote(symbol: 'EUR/GBP', value: (rates['GBP'] as num).toDouble(), delta: -0.08),
        RateQuote(symbol: 'EUR/JPY', value: (rates['JPY'] as num).toDouble(), delta: 0.34),
      ];
    } catch (_) {
      return const [
        RateQuote(symbol: 'EUR/USD', value: 1.085, delta: 0.18),
        RateQuote(symbol: 'EUR/GBP', value: 0.842, delta: -0.05),
        RateQuote(symbol: 'EUR/JPY', value: 169.4, delta: 0.31),
      ];
    }
  }
}

import 'package:aurora_bank/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shows LumaVault login screen', (tester) async {
    await tester.pumpWidget(const LumaVaultApp());

    expect(find.text('LumaVault'), findsOneWidget);
    expect(find.text('Войти'), findsOneWidget);
  });
}

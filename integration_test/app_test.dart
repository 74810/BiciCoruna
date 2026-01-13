import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:bicicoruna/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('E2E: Flujo completo de arranque', (tester) async {
    app.main();
    
    await tester.pumpAndSettle(const Duration(seconds: 4));

    expect(find.text('BiciCoruña'), findsOneWidget);
    expect(find.text('Selección de estación...'), findsOneWidget);
  });
}
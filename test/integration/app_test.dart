import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:minsk_transport_crossplatform/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end tests', () {
    testWidgets('Login flow works', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      expect(find.text('Minsk Transport'), findsOneWidget);
    });
    
    testWidgets('Routes list loads', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Войти'));
      await tester.pumpAndSettle();
      
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}

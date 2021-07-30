import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart' show MyKareeApp;

/*
 * @Author Champlain Marius Bakop
 * @Email champlainmarius20@gmail.com
 * @Github ChamplainLeCode
 * 
 */
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Karee app set', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyKareeApp());
    expect(1, 1);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:klikshikdemo/main.dart';

void main() {
  testWidgets('App starts with auth screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Continue with Google'), findsOneWidget);
  });
}

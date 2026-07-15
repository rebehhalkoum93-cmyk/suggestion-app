import 'package:flutter_test/flutter_test.dart';
import 'package:sug/main.dart';

void main() {
  testWidgets('Smoke test questionnaire flow navigation', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that category options are visible on landing page.
    expect(find.text('Music'), findsOneWidget);
    expect(find.text('Movie'), findsOneWidget);
    expect(find.text('Series'), findsOneWidget);

    // Tap on Music and trigger navigation transition
    await tester.tap(find.text('Music'));
    await tester.pumpAndSettle();

    // Verify we transitioned to the questionnaire page instructions
    expect(find.text('Please answer the following questions'), findsOneWidget);
  });
}

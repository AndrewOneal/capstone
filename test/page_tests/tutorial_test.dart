import 'package:capstone/Pages/tutorial.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  test('Home Page Displays', () {
    const homePage = TutorialPage();
    expect(homePage, isNotNull);
  });

  testWidgets('Home Page UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TutorialPage()));
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);
    expect(find.text('The Spoiler-Free Wikipedia'), findsOneWidget);
    expect(
        find.widgetWithText(Card,
            'Welcome to SpoilerGuard, the spoiler-free wikipedia made to keep you safe! Begin your search by following these 3 easy steps.'),
        findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Get Started'), findsOneWidget);
  });
}

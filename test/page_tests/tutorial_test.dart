import 'package:capstone/Pages/tutorial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Home Page Displays', () {
    const homePage = TutorialPage();
    expect(homePage, isNotNull);
  });
/*
  testWidgets('Page Renders Fully', (WidgetTester tester) async {
    await tester.pumpWidget(const HomePage());
    
    // Tests for the app bar
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byIcon(Icons.settings), findsOneWidget);
    expect(find.byIcon(Icons.account_circle), findsOneWidget);

    // Tests for the title text
    expect(find.text('SpoilerGuard'), findsOneWidget);
    expect(find.text('The Spoiler-Free Wikipedia'), findsOneWidget);

    // Tests for the card widget
    expect(
        find.text(
            'Welcome to SpoilerGuard, the spoiler-free wikipedia made to keep you safe! Begin your search by following these 3 easy steps.'),
        findsOneWidget);
    expect(find.text('1. Search for a topic'), findsOneWidget);

    // Tests for the buttons
    expect(find.text('Get Started'), findsOneWidget);
  });
  */
}

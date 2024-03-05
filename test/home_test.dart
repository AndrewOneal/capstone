import 'package:capstone/Pages/home.dart';
import 'package:test/test.dart';

void main() {
  test('Home Page Displays', () {
    const homePage = HomePage();
    expect(homePage, isNotNull);
  });

  test('Title Text Displays', () {
    const titleText = TitleText();
    expect(titleText, isNotNull);
  });

  test('Get Started Button Displays', () {
    const getStartedButton = GetStartedButton();
    expect(getStartedButton, isNotNull);
  });

  test('Card Widget Diplays', () {
    const cardWidget = CardWidget();
    expect(cardWidget, isNotNull);
  });
}

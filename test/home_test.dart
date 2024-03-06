import 'package:capstone/Pages/home.dart';
import 'package:capstone/Utilities/theme.dart';
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

  test('Card Widget Diplays', () {
    const cardWidget = CardWidget();
    expect(cardWidget, isNotNull);
  });
}

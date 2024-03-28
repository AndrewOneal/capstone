import 'package:capstone/Pages/Account/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Login Page Displays', () {
    const loginPage = LoginPage();
    expect(loginPage, isNotNull);
  });

  test('Login Form Displays', () {
    const loginForm = LoginForm();
    expect(loginForm, isNotNull);
  });
}

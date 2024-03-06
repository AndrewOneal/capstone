import 'package:capstone/Pages/login.dart';
import 'package:test/test.dart';

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

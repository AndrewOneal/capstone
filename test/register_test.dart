import 'package:capstone/Pages/register.dart';
import 'package:test/test.dart';

void main() {
  test('Register Page Displays', () {
    const registerPage = RegisterPage();
    expect(registerPage, isNotNull);
  });

  test('Register Form Displays', () {
    const registerForm = RegisterForm();
    expect(registerForm, isNotNull);
  });
}

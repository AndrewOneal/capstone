import 'package:capstone/Pages/Account/change_password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Change Password Page Displays', () {
    const changePasswordPage = CPPage();
    expect(changePasswordPage, isNotNull);
  });

  test('Change Password Form Displays', () {
    const changePasswordForm = CPFields();
    expect(changePasswordForm, isNotNull);
  });
}

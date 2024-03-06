import 'package:capstone/Pages/change_password.dart';
import 'package:flutter/material.dart';
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

import 'package:capstone/Pages/Account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Account Page Displays', () {
    const accountPage = AccountPage();
    expect(accountPage, isNotNull);
  });

  test('Account Form Displays', () {
    const accountForm = AccountFields();
    expect(accountForm, isNotNull);
  });
}

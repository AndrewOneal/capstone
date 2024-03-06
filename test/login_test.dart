import 'package:capstone/Pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone/main.dart';

void main() {
  test('Login Page Displays', () {
    const loginPage = LoginPage();
    expect(loginPage, isNotNull);
  });

  test('Login Form Displays', () {
    const loginForm = LoginFields();
    expect(loginForm, isNotNull);
  });
}

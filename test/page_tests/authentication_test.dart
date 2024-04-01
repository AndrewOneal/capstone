import 'package:capstone/Pages/Account/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone/Pages/Account/register.dart';
import 'package:capstone/Pages/Account/login.dart';

void main() {
  group('Register Page Tests', () {
    test('Page Displays', () {
      const registerPage = RegisterPage();
      expect(registerPage, isNotNull);
    });

    testWidgets('Page UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
      expect(find.text('Register'), findsExactly(2));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Already have an account?'), findsOneWidget);
      expect(find.text('Click to Login'), findsOneWidget);
    });

    testWidgets('to Login Page Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
      final button = find.text('Click to Login');
      expect(button, findsOneWidget);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Register Account Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
      final registerButton = find.text('Register').last;
      await tester.ensureVisible(registerButton);
      await tester.tap(registerButton);
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });

  /*group('Account Page Tests', () {
    test('Page Displays', () {
      const accountPage = AccountPage();
      DBHandler().authenticate(username: 'testuser', password: 'P@ssw0rd');
      expect(accountPage, isNotNull);
    });

    testWidgets('Page UI Test', (WidgetTester tester) async {
      DBHandler().authenticate(username: 'testuser', password: 'P@ssw0rd');
      await tester.pumpWidget(const MaterialApp(home: AccountPage()));
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
      expect(find.text('Admin Panel'), findsOneWidget);
    });
  });*/

  group('Login Page Tests', () {
    test('Page Displays', () {
      const loginPage = LoginPage();
      expect(loginPage, isNotNull);
    });

    testWidgets('Page UI Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      expect(find.text('Login'), findsExactly(2));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text("Don't have an account?"), findsOneWidget);
      expect(find.text('Click to Register'), findsOneWidget);
    });

    testWidgets('to Register Page Button Test', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      final button = find.text('Click to Register');
      expect(button, findsOneWidget);
      await tester.ensureVisible(button);
      await tester.tap(button);
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}

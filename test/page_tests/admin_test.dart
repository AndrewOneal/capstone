import 'package:capstone/Pages/Admin/admin_portal.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:capstone/Pages/Admin/verification.dart';
import 'sample_wiki.dart';

void main() {
  group('Admin Portal Tests', () {
    test('Page Displays', () {
      const adminPortal = AdminPortal(adminWikis: sampleWikis);
      expect(adminPortal, isNotNull);
    });
  });

  group('Verification Page Tests', () {
    test('Page Displays', () {
      const verificationPage = VerificationPage(wikiMap: sampleWiki);
      expect(verificationPage, isNotNull);
    });
  });
}

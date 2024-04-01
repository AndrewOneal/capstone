import 'package:capstone/Pages/wiki_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  test('Wiki List Page Displays', () {
    const homePage = WikiListPage();
    expect(homePage, isNotNull);
  });
}

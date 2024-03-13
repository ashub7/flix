import 'dart:math';

import '../utils/constants.dart';

extension StringUtils on String {
  static final newLineRegEx = RegExp(r"\n+");

  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidPassword() {
    return length>=6;
    /*   return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(this);*/
  }

  String? getInitials() {
    String name = trim();
    final parts = name.split(RegExp(' +'));
    if (parts.length == 1) {
      return name.substring(0, min(2, length)).toUpperCase();
    }
    return isNotEmpty
        ? parts.map((s) => s[0].toUpperCase()).take(2).join()
        : '';
  }
}

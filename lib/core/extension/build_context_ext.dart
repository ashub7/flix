import 'package:flix/core/extension/color_extension.dart';
import 'package:flix/core/extension/text_style_extension.dart';
import 'package:flix/ui/config/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension DarkMode on BuildContext {
  bool get isDarkMode {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }

  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
}

extension BuildContextUtils on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);

  showSnackBar(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: titleMedium,
        ),
      ),
    );
  }

  showSnackBarWithAction(String message, String actionTitle, Function() onActionClicked) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 3),
        content: Text(
          message,
          style: titleMedium?.copyWith(
            color: Colors.white
          ),
        ),
        action: SnackBarAction(
          label: actionTitle, onPressed: () => onActionClicked.call(),
        ),
      ),
    );
  }

  showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: titleMedium,
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.green,
      ),
    );
  }

  showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(
          message,
          style: titleMedium,
        ),
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.red,
      ),
    );
  }

  Future<DateTime?> showDobPicker() async {
    DateTime? dateTime = await showDatePicker(
        context: this,
        firstDate: DateTime(1950),
        lastDate:  DateTime.now());
    return dateTime;
  }
}

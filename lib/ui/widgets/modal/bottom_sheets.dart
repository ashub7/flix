import 'package:flutter/material.dart';

Future<T> showModalWithRoundedTopCorner<T>(
    {required BuildContext context, required Widget child}) async {
  return await showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      context: context,
      builder: (context) {
        return child;
      });
}

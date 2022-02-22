import 'package:flutter/material.dart';

class ProgressDialog {
  ProgressDialog._();

  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => WillPopScope(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
        onWillPop: () async => false,
      ),
    );
  }
}

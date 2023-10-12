import '../../../global_widgets/progress_dialog.dart';
import '../controller/login_provider.dart';
import '../../../routes/routes.dart';
import 'package:flutter/material.dart';

Future<void> sendLoginForm(BuildContext context) async {
  ProgressDialog.show(context);
  final result = await loginProvider.read().submit();
  if (!context.mounted) {
    return;
  }

  Navigator.pop(context);

  result.fold(
    (loginFailure) {
      final String errorMessage = loginFailure.when(
        accessDenied: () => "Invalid credentials",
        network: () => "Network error",
        unknown: () => "Unknown error",
      );

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text(errorMessage),
        ),
      );
    },
    (_) => Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.PROFILE,
      (_) => false,
    ),
  );
}

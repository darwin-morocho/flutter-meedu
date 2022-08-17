import 'package:example/app/ui/global_widgets/progress_dialog.dart';
import 'package:example/app/ui/pages/login/controller/login_provider.dart';
import 'package:example/app/ui/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_meedu/ui.dart';

Future<void> sendLoginForm(BuildContext context) async {
  ProgressDialog.show(context);
  final result = await loginProvider.read.submit();
  router.pop();

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
    (_) => router.pushNamedAndRemoveUntil(
      Routes.PROFILE,
    ),
  );
}

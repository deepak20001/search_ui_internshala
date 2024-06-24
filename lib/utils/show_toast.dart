import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Flushbar showToast({required BuildContext context, required String message, required Color color}) {
  return Flushbar(
    message: message,
    duration: const Duration(seconds: 3),
    backgroundColor: color,
  )..show(context);
}

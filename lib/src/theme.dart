import 'package:flutter/material.dart';

enum PinCodeFieldShape { box, underline, circle }

class PinTheme {
  /// Colors of the input fields which have inputs. Default is [Colors.black]
  final Color keysColor;

  /// Color of the texts and labels
  final Color? textColor;

  const PinTheme.defaults({
    this.textColor = Colors.blue,
    this.keysColor = Colors.black,
  });

  factory PinTheme({
    Color? textColor,
    Color? keysColor,
  }) {
    const defaultValues = PinTheme.defaults();
    return PinTheme.defaults(
      textColor: textColor ?? defaultValues.textColor,
      keysColor: keysColor ?? defaultValues.keysColor,
    );
  }
}

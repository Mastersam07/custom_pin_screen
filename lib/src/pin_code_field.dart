import 'package:flutter/material.dart';

import 'theme.dart';

/// PinCodeField
class PinCodeField extends StatelessWidget {
  const PinCodeField({
    Key? key,
    required this.pin,
    required this.pinCodeFieldIndex,
    required this.theme,
  }) : super(key: key);

  /// The pin code
  final String pin;

  /// The the index of the pin code field
  final PinTheme theme;

  /// The index of the pin code field
  final int pinCodeFieldIndex;

  Color get getFillColorFromIndex {
    if (pin.length > pinCodeFieldIndex) {
      return theme.activeFillColor;
    } else if (pin.length == pinCodeFieldIndex) {
      return theme.selectedFillColor;
    }
    return theme.inactiveFillColor;
  }

  @override
  Widget build(BuildContext context) {
    BorderRadius? borderRadius;
    if (theme.shape != PinCodeFieldShape.circle &&
        theme.shape != PinCodeFieldShape.underline) {
      borderRadius = theme.borderRadius;
    }
    return AnimatedContainer(
      height: theme.fieldHeight,
      width: theme.fieldWidth,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: theme.shape == PinCodeFieldShape.underline
            ? Colors.transparent
            : getFillColorFromIndex,
        borderRadius: borderRadius,
        shape: theme.shape == PinCodeFieldShape.circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        border: theme.shape == PinCodeFieldShape.underline
            ? Border(
                bottom: BorderSide(
                  color: getFillColorFromIndex,
                  width: theme.borderWidth,
                ),
              )
            : Border.all(
                color: getFillColorFromIndex,
                width: theme.borderWidth,
              ),
      ),
      duration: const Duration(microseconds: 40000),
      child: pin.length > pinCodeFieldIndex
          ? const Icon(
              Icons.circle,
              color: Colors.white,
              size: 12,
            )
          : const SizedBox(),
    );
  }
}

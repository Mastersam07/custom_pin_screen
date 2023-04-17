import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';

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
      return Colors.green;
    } else if (pin.length == pinCodeFieldIndex) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: getFillColorFromIndex,
        borderRadius: BorderRadius.zero,
        shape: BoxShape.rectangle,
        border: Border.all(
          color: getFillColorFromIndex,
          width: 2,
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

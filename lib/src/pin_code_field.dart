import 'package:flutter/material.dart';

class PinCodeField extends StatelessWidget {
  const PinCodeField({
    Key key,
    @required this.pin,
    @required this.pinCodeFieldIndex,
  }) : super(key: key);

  final String pin;
  final int pinCodeFieldIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 50,
      width: 50,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FF).withOpacity(0.13),
        borderRadius: BorderRadius.circular(5),
        border: pin.length > pinCodeFieldIndex
            ? Border.all(color: Colors.blue)
            : null,
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

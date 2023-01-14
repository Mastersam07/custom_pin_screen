import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

PinTheme kPinCodeStyle = PinTheme(
    shape: PinCodeFieldShape.underline,
    borderWidth: 2,
    borderRadius: BorderRadius.circular(5),
    fieldHeight: 50,
    fieldWidth: 50,
    inactiveColor: Colors.grey.shade100,
    activeColor: Colors.green,
    selectedColor: Colors.greenAccent,
    inactiveFillColor: Colors.grey.shade100,
    activeFillColor: Colors.grey.shade100,
    selectedFillColor: Colors.grey.shade100

);
import 'package:flutter/material.dart';

enum PinCodeFieldShape { box, underline, circle }

class KeyBoardPinTheme {
  /// Colors of the input fields which have inputs. Default is [Colors.white]
  final Color backgroundColor;

  /// Color of the submit button
  final Color submitColor;

  /// Colors of the input fields which have inputs. Default is [Colors.black]
  final Color keysColor;

  /// Color of the texts and labels
  final Color? textColor;

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedColor;

  /// Colors of the input fields which don't have inputs. Default is [Colors.red]
  final Color inactiveColor;

  /// Colors of the input fields which have inputs. Default is [Colors.green]
  final Color activeFillColor;

  /// Color of the input field which is currently selected. Default is [Colors.blue]
  final Color selectedFillColor;

  /// Colors of the input fields which don't have inputs. Default is [Colors.red]
  final Color inactiveFillColor;

  /// Border radius of each pin code field
  final BorderRadius borderRadius;

  /// [height] for the pin code field. default is [50.0]
  final double fieldHeight;

  /// [width] for the pin code field. default is [50.0]
  final double fieldWidth;

  /// Border width for the each input fields. Default is [2.0]
  final double borderWidth;

  /// this defines the shape of the input fields. Default is underlined
  final PinCodeFieldShape shape;

  /// this defines the padding of each enclosing container of an input field. Default is [0.0]
  final EdgeInsetsGeometry fieldOuterPadding;

  const KeyBoardPinTheme.defaults({
    this.backgroundColor = Colors.white,
    this.textColor = Colors.blue,
    this.keysColor = Colors.black,
    this.submitColor = Colors.blue,
    this.borderRadius = BorderRadius.zero,
    this.fieldHeight = 50,
    this.fieldWidth = 50,
    this.borderWidth = 2,
    this.fieldOuterPadding = EdgeInsets.zero,
    this.shape = PinCodeFieldShape.box,
    this.activeColor = Colors.green,
    this.selectedColor = Colors.blue,
    this.inactiveColor = Colors.red,
    this.activeFillColor = Colors.green,
    this.selectedFillColor = Colors.blue,
    this.inactiveFillColor = Colors.red,
  });

  factory KeyBoardPinTheme(
      {Color? backgroundColor,
      Color? textColor,
      Color? submitColor,
      Color? keysColor,
      Color? activeColor,
      Color? selectedColor,
      Color? inactiveColor,
      Color? activeFillColor,
      Color? selectedFillColor,
      Color? inactiveFillColor,
      BorderRadius? borderRadius,
      double? fieldHeight,
      double? fieldWidth,
      double? borderWidth,
      PinCodeFieldShape? shape,
      EdgeInsetsGeometry? fieldOuterPadding}) {
    const defaultValues = KeyBoardPinTheme.defaults();
    return KeyBoardPinTheme.defaults(
      backgroundColor: backgroundColor ?? defaultValues.backgroundColor,
      textColor: textColor ?? defaultValues.textColor,
      submitColor: submitColor ?? defaultValues.submitColor,
      keysColor: keysColor ?? defaultValues.keysColor,
      activeColor: activeColor ?? defaultValues.activeColor,
      activeFillColor: activeFillColor ?? defaultValues.activeFillColor,
      borderRadius: borderRadius ?? defaultValues.borderRadius,
      borderWidth: borderWidth ?? defaultValues.borderWidth,
      fieldHeight: fieldHeight ?? defaultValues.fieldHeight,
      fieldWidth: fieldWidth ?? defaultValues.fieldWidth,
      inactiveColor: inactiveColor ?? defaultValues.inactiveColor,
      inactiveFillColor: inactiveFillColor ?? defaultValues.inactiveFillColor,
      selectedColor: selectedColor ?? defaultValues.selectedColor,
      selectedFillColor: selectedFillColor ?? defaultValues.selectedFillColor,
      shape: shape ?? defaultValues.shape,
      fieldOuterPadding: fieldOuterPadding ?? defaultValues.fieldOuterPadding,
    );
  }
}

import 'package:custom_pin_screen/src/src.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Custom keyboard
class CustomKeyBoard extends StatefulWidget {
  /// Theme for the widget. Read more [PinTheme]
  final KeyBoardPinTheme pinTheme;

  /// special key to be displayed on the widget. Default is '.'
  final Widget? specialKey;

  /// on pressed function to be called when the submit button is pressed.
  final Function? onbuttonClick;

  /// on changed function to be called when the amount is changed.
  final Function(String)? onChanged;

  /// function to be called when special keys are pressed.
  final Function()? specialKeyOnTap;

  /// submit button text.
  final Widget? submitLabel;

  /// maximum length of the amount.
  final int? maxLength;

  const CustomKeyBoard({
    Key? key,
    required this.maxLength,
    this.pinTheme = const KeyBoardPinTheme.defaults(),
    this.specialKey,
    this.onbuttonClick,
    this.onChanged,
    this.specialKeyOnTap,
    this.submitLabel,
  }) : super(key: key);
  @override
  _CustomKeyBoardState createState() => _CustomKeyBoardState();
}

class _CustomKeyBoardState extends State<CustomKeyBoard> {
  String value = "";
  Widget buildNumberButton({int? number, Widget? icon, Function()? onPressed}) {
    getChild() {
      if (icon != null) {
        return icon;
      } else {
        return Text(
          number?.toString() ?? "",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: widget.pinTheme.keysColor,
          ),
        );
      }
    }

    return Expanded(
        child: CupertinoButton(
            key: icon?.key ?? Key("btn$number"),
            onPressed: onPressed,
            child: getChild()));
  }

  Widget buildNumberRow(List<int> numbers) {
    List<Widget> buttonList = numbers
        .map((buttonNumber) => buildNumberButton(
              number: buttonNumber,
              onPressed: () {
                if (value.length < widget.maxLength!) {
                  setState(() {
                    value = value + buttonNumber.toString();
                  });
                  widget.onChanged!(value);
                }
              },
            ))
        .toList();
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttonList,
    ));
  }

  Widget buildSpecialRow() {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildNumberButton(
            icon: widget.specialKey ??
                Icon(
                  Icons.circle,
                  key: const Key('specialKey'),
                  color: widget.pinTheme.keysColor,
                  size: 7,
                ),
            onPressed: widget.specialKeyOnTap ??
                () {
                  if (value.length < widget.maxLength!) {
                    if (!value.contains(".")) {
                      setState(() {
                        value = value + ".";
                      });
                    }
                    widget.onChanged!(value);
                  }
                },
          ),
          buildNumberButton(
            number: 0,
            onPressed: () {
              if (value.length < widget.maxLength!) {
                setState(() {
                  value = value + 0.toString();
                });
                widget.onChanged!(value);
              }
            },
          ),
          buildNumberButton(
              icon: Icon(
                Icons.backspace,
                key: const Key('backspace'),
                color: widget.pinTheme.keysColor,
              ),
              onPressed: () {
                if (value.isNotEmpty) {
                  setState(() {
                    value = value.substring(0, value.length - 1);
                  });
                }
                widget.onChanged!(value);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maxLength == null || widget.maxLength! < 1) {
      throw AssertionError('maxLength must be greater than 0');
    }
    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Text(
          "₦$value",
          key: const Key('amtKey'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.pinTheme.textColor,
            fontWeight: FontWeight.w700,
            fontSize: 48,
          ),
        ),
        const SizedBox(
          height: 80,
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: [
                buildNumberRow([1, 2, 3]),
                buildNumberRow([4, 5, 6]),
                buildNumberRow([7, 8, 9]),
                buildSpecialRow(),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            widget.onbuttonClick!();
          },
          child: Container(
            color: widget.pinTheme.submitColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Center(
                child: widget.submitLabel ??
                    const Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

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
  // final TextEditingController value;
  final TextEditingController? controller;
  const CustomKeyBoard({
    Key? key,
    required this.maxLength,
    this.controller,
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
                if (widget.controller!.text.length < widget.maxLength!) {
                  setState(() {
                    widget.controller!.text =
                        widget.controller!.text + buttonNumber.toString();
                  });
                  widget.onChanged!(widget.controller!.text);
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
                  if (widget.controller!.text.length < widget.maxLength!) {
                    if (!widget.controller!.text.contains(".")) {
                      setState(() {
                        widget.controller!.text = widget.controller!.text + ".";
                      });
                    }
                    widget.onChanged!(widget.controller!.text);
                  }
                },
          ),
          buildNumberButton(
            number: 0,
            onPressed: () {
              if (widget.controller!.text.length < widget.maxLength!) {
                setState(() {
                  widget.controller!.text =
                      widget.controller!.text + 0.toString();
                });
                widget.onChanged!(widget.controller!.text);
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
                if (widget.controller!.text.isNotEmpty) {
                  setState(() {
                    widget.controller!.text = widget.controller!.text
                        .substring(0, widget.controller!.text.length - 1);
                  });
                }
                widget.onChanged!(widget.controller!.text);
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
      ],
    );
  }
}

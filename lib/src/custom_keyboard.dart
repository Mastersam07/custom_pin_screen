import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppKeyBoard extends StatefulWidget {
  final Color numpadColor;
  final Color amountColor;
  final Color submitColor;
  final Widget specialKey;
  final Function onbuttonClick;
  final Function(String) onChanged;
  final Function() specialKeyOnTap;
  final Widget submitLabel;
  final int maxLength;
  const CustomAppKeyBoard({
    Key key,
    @required this.maxLength,
    this.numpadColor,
    this.specialKey,
    this.onbuttonClick,
    this.onChanged,
    this.specialKeyOnTap,
    this.submitLabel,
    this.amountColor,
    this.submitColor,
  }) : super(key: key);
  @override
  _CustomAppKeyBoardState createState() => _CustomAppKeyBoardState();
}

class _CustomAppKeyBoardState extends State<CustomAppKeyBoard> {
  String value = "";
  Widget buildNumberButton({int number, Widget icon, Function onPressed}) {
    getChild() {
      if (icon != null) {
        return icon;
      } else {
        return Text(
          number?.toString() ?? "",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: widget.numpadColor ?? Colors.red,
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
                if (value.length < widget.maxLength) {
                  setState(() {
                    value = value + buttonNumber.toString();
                  });
                  widget.onChanged(value);
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
                  color: widget.numpadColor ?? Colors.red,
                  size: 7,
                ),
            onPressed: widget.specialKeyOnTap ??
                () {
                  if (value.length < widget.maxLength) {
                    if (!value.contains(".")) {
                      setState(() {
                        value = value + ".";
                      });
                    }
                    widget.onChanged(value);
                  }
                },
          ),
          buildNumberButton(
            number: 0,
            onPressed: () {
              if (value.length < widget.maxLength) {
                setState(() {
                  value = value + 0.toString();
                });
                widget.onChanged(value);
              }
            },
          ),
          buildNumberButton(
              icon: Icon(
                Icons.backspace,
                key: const Key('backspace'),
                color: widget.numpadColor ?? Colors.red,
              ),
              onPressed: () {
                if (value.isNotEmpty) {
                  setState(() {
                    value = value.substring(0, value.length - 1);
                  });
                }
                widget.onChanged(value);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.maxLength == null || widget.maxLength < 1) {
      throw AssertionError('maxLength must be greater than 0');
    }
    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Text(
          "₦${value ?? "0.00"}",
          key: const Key('amtKey'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: widget.amountColor ?? Colors.blue,
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
            widget.onbuttonClick();
          },
          child: Container(
            color: widget.submitColor ?? Colors.blue,
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

import 'package:flutter/material.dart';

import 'pin_code_field.dart';

class PinAuthentication extends StatefulWidget {
  final String action;
  final String actionDescription;
  final Widget submitLabel;
  final Function onbuttonClick;
  final Function(String) onChanged;
  final Function onSpecialKeyTap;
  final bool useFingerprint;
  final Widget specialKey;
  final Color backgroundColor;

  const PinAuthentication({
    Key key,
    this.action,
    this.backgroundColor,
    this.onSpecialKeyTap,
    this.actionDescription,
    this.submitLabel,
    this.onbuttonClick,
    this.onChanged,
    this.specialKey,
    this.useFingerprint = false,
  }) : super(key: key);
  @override
  _PinAuthenticationState createState() => _PinAuthenticationState();
}

class _PinAuthenticationState extends State<PinAuthentication> {
  String pin = "";
  Widget buildNumberButton({int number, Widget icon, Function onPressed}) {
    getChild() {
      if (icon != null) {
        return icon;
      } else {
        return Text(
          number?.toString() ?? "",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        );
      }
    }

    return InkResponse(
      onTap: onPressed,
      key: icon?.key ?? Key("btn$number"),
      child: Container(
          height: 80,
          width: 80,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Center(child: getChild())),
    );
  }

  Widget buildNumberRow(List<int> numbers) {
    List<Widget> buttonList = numbers
        .map((buttonNumber) => buildNumberButton(
              number: buttonNumber,
              onPressed: () {
                if (pin.length < 4) {
                  setState(() {
                    pin = pin + buttonNumber.toString();
                  });
                }
                widget.onChanged(pin);
              },
            ))
        .toList();
    return Expanded(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: buttonList,
    ));
  }

  Widget buildSpecialRow() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNumberButton(
              icon: widget.useFingerprint
                  ? const Icon(
                      Icons.fingerprint,
                      key: Key('fingerprint'),
                      color: Colors.white,
                      size: 50,
                    )
                  : widget.specialKey ?? const SizedBox(),
              onPressed: widget.onSpecialKeyTap),
          buildNumberButton(
            number: 0,
            onPressed: () {
              if (pin.length < 4) {
                setState(() {
                  pin = pin + 0.toString();
                });
              }
              widget.onChanged(pin);
            },
          ),
          buildNumberButton(
              icon: const Icon(
                Icons.backspace,
                key: Key('backspace'),
                color: Colors.white,
              ),
              onPressed: () {
                if (pin.isNotEmpty) {
                  setState(() {
                    pin = pin.substring(0, pin.length - 1);
                  });
                }
                widget.onChanged(pin);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useFingerprint && widget.onSpecialKeyTap == null) {
      throw AssertionError("You can't use fingerprint without onSpecialKeyTap");
    }
    if (widget.specialKey != null && widget.onSpecialKeyTap == null) {
      throw AssertionError("You can't use specialKey without onSpecialKeyTap");
    }
    if (widget.specialKey == null &&
        widget.useFingerprint == false &&
        widget.onSpecialKeyTap != null) {
      throw AssertionError(
          "You can't use specialKey onSpecialKeyTap on empty special key");
    }
    if ((widget.submitLabel != null && widget.onbuttonClick == null) ||
        (widget.submitLabel == null && widget.onbuttonClick != null)) {
      throw AssertionError(
          "You can't use submitLabel onbuttonClick on empty submitLabel");
    }
    return Scaffold(
      backgroundColor: widget.backgroundColor ?? Colors.blue,
      body: Column(
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          Text(
            widget.action ?? "Enter PIN",
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.actionDescription ?? "Please enter your pin to continue",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 4; i++)
                PinCodeField(
                  key: Key('pinField$i'),
                  pin: pin,
                  pinCodeFieldIndex: i,
                ),
            ],
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
            key: const Key('submit'),
            onTap: () {
              widget.onbuttonClick();
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
              child: Center(
                child: widget.submitLabel,
              ),
            ),
          )
        ],
      ),
    );
  }
}

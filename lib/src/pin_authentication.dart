import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'theme.dart';
import 'pin_code_field.dart';

/// Pin authentication screen
class PinAuthentication extends StatefulWidget {
  /// title to be displayed on the widget. Default is 'Enter PIN'
  final String? action;

  /// subtitle/description to be displayed on the widget. Default is 'Enter your PIN to continue'
  final String? actionDescription;

  /// submit button text.
  final Widget? submitLabel;

  /// on pressed function to be called when the submit button is pressed.
  final Function? onbuttonClick;

  /// on changed function to be called when the pin code is changed.
  final Function(String)? onChanged;

  /// on competed function to be called when the pin code is complete.
  final Function(String)? onCompleted;

  /// function to be called when special keys are pressed.
  final Function()? onSpecialKeyTap;

  /// Theme for the widget and pin cells. Read more [PinTheme]
  final PinTheme pinTheme;

  /// Decides whether finger print is enabled or not. Default is false
  final bool? useFingerprint;

  /// special key to be displayed on the widget. Default is 'backspace'
  final Widget? specialKey;

  /// maximum length of pin.
  final int maxLength;

  const PinAuthentication({
    Key? key,
    this.action,
    this.onSpecialKeyTap,
    this.actionDescription,
    this.submitLabel,
    this.onbuttonClick,
    this.onChanged,
    this.specialKey,
    this.maxLength = 4,
    this.pinTheme = const PinTheme.defaults(),
    this.useFingerprint = false,
    this.onCompleted,
  })  : assert(maxLength > 0 && maxLength < 7),
        super(key: key);
  @override
  _PinAuthenticationState createState() => _PinAuthenticationState();
}

class _PinAuthenticationState extends State<PinAuthentication> {
  String pin = "";
  PinTheme get _pinTheme => widget.pinTheme;
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
              onPressed: () async {
                if (pin.length < widget.maxLength) {
                  setState(() {
                    pin = pin + buttonNumber.toString();
                  });
                }
                widget.onChanged!(pin);
                if (pin.length >= 4 && widget.onCompleted != null) {
                  widget.onCompleted!(pin);
                }
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
              icon: widget.useFingerprint!
                  ? Icon(
                      Icons.fingerprint,
                      key: const Key('fingerprint'),
                      color: widget.pinTheme.keysColor,
                      size: 50,
                    )
                  : widget.specialKey ?? const SizedBox(),
              onPressed: widget.onSpecialKeyTap),
          buildNumberButton(
            number: 0,
            onPressed: () async {
              if (pin.length < widget.maxLength) {
                setState(() {
                  pin = pin + 0.toString();
                });
              }
              widget.onChanged!(pin);
              if (pin.length >= 4 && widget.onCompleted != null) {
                await widget.onCompleted!(pin);
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
                if (pin.isNotEmpty) {
                  setState(() {
                    pin = pin.substring(0, pin.length - 1);
                  });
                }
                widget.onChanged!(pin);
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.useFingerprint! && widget.onSpecialKeyTap == null) {
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
      backgroundColor: widget.pinTheme.backgroundColor,
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
              // color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.actionDescription ?? "Please enter your pin to continue",
            style: const TextStyle(
              // color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          PinCodeTextField(
            appContext: context,
            pastedTextStyle: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
            obscureText: false,
            obscuringCharacter: '*',
            autoFocus: true,
            readOnly: true,
            autoDisposeControllers: false,
            animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 4) {
                return 'pin less than 4';
              } else {
                return null;
              }
            },
            pinTheme: kPinCodeStyle,
            animationDuration: const Duration(milliseconds: 300),
            textStyle: kPinCodeTextStyle,
            enableActiveFill: true,
            errorAnimationController: errorController,
            controller: pin,
            keyboardType: TextInputType.number,
            boxShadows: const [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
                blurRadius: 10,
              )
            ],
            onCompleted: (v) async {
             debugPrint(v);

            },
            // onTap: () {
            //   print("Pressed");
            // },
            onChanged: (value){
              debugPrint("Value ===> $value");
              setState(()  {
                currentText = value;

              });
            },
            beforeTextPaste: (text) {
              out("Allowing to paste $text");
              return true;
            },
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
              widget.onbuttonClick!();
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

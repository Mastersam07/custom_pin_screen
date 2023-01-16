import 'package:custom_pin_screen/src/src.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pin_code_fields/pin_code_fields.dart' as pin_code;

void main() {
  testWidgets('pin authentication works well...', (tester) async {
    String? pin;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PinAuthentication(
            key: const Key('keyboardKey'),
            onChanged: (p0) {
              pin = p0;
            },
            obscureText: false,
            pinTheme: pin_code.PinTheme(),
          ),
        ),
      ),
    );

    // Checks if widget renders
    var keyboardWidgetfinder = find.byKey(const Key('keyboardKey'));
    var pinFieldfinder = find.byType(PinCodeField);

    expect(keyboardWidgetfinder, findsOneWidget);
    expect(pinFieldfinder, findsNWidgets(4));

    // Tap keys

    await tester.tap(find.byKey(const Key("btn1")));
    await tester.tap(find.byKey(const Key("btn2")));
    await tester.tap(find.byKey(const Key("btn3")));
    await tester.tap(find.byKey(const Key("btn4")));
    await tester.pump();
    assert(pin == "1234");

    // Delete a digit

    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("backspace")))));
    await tester.pump();
    assert(pin == "123");

    // Add Zero

    await tester.tap(find.byKey(const Key("btn0")));
    await tester.pump();
    assert(pin == "1230");
  });

  testWidgets(
      'pin authentication throws exception when only special key method is passed...',
      (tester) async {
    String? pin;
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PinAuthentication(
            key: const Key('keyboardKey'),
            onChanged: (p0) {
              pin = p0;
            },
            onSpecialKeyTap: () {
              if (kDebugMode) {
                print(pin);
              }
            },
            obscureText: false,
            pinTheme: pin_code.PinTheme(),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isAssertionError);
  });

  testWidgets(
      'pin authentication throws exception when fingerprint is true but no special key method is passed...',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PinAuthentication(
            key: const Key('keyboardKey'),
            onChanged: (p0) {},
            useFingerprint: true,
            obscureText: false,
            pinTheme: pin_code.PinTheme(),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isAssertionError);
  });

  testWidgets(
      'pin authentication throws exception when only special key is passed but no method...',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PinAuthentication(
            pinTheme: pin_code.PinTheme(),
            key: const Key('keyboardKey'),
            onChanged: (p0) {
              if (kDebugMode) {
                print(p0);
              }
            },
            specialKey: const Text('A'),
            obscureText: false,
          ),
        ),
      ),
    );

    expect(tester.takeException(), isAssertionError);
  });

  testWidgets(
      'pin authentication throws exception when one of submit label or submit label clicked is passed...',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: PinAuthentication(
            key: const Key('keyboardKey'),
            onChanged: (p0) {
              if (kDebugMode) {
                print(p0);
              }
            },
            submitLabel: const Text('A'),
            obscureText: false,
            pinTheme: pin_code.PinTheme(),
          ),
        ),
      ),
    );

    expect(tester.takeException(), isAssertionError);
  });
}

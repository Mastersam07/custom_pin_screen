import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'custom keyboard throws exception when maxLenght is less than 0 or null...',
      (tester) async {
    expect(() => CustomKeyBoard(maxLength: -1), throwsAssertionError);
  });

  testWidgets('custom keyboard is displayed ...', (tester) async {
    const length = 7;
    String value = "";
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            CustomKeyBoard(
              pinTheme: PinTheme(
                keysColor: Colors.white,
              ),
              key: const Key('keyboardKey'),
              maxLength: length,
              onChanged: (p0) {
                value = p0;
              },
            ),
          ],
        ),
      ),
    );

    // Checks if widget renders
    var keyboardWidgetfinder = find.byKey(const Key('keyboardKey'));

    expect(keyboardWidgetfinder, findsOneWidget);
    expect(find.byKey(const Key("btn1")), findsOneWidget);

    // Tap keys
    await tester.tap(find.byKey(const Key("btn1")));
    await tester.tap(find.byKey(const Key("btn2")));
    await tester.tap(find.byKey(const Key("btn3")));
    await tester.tap(find.byKey(const Key("btn4")));
    await tester.pump();
    expect(value, "1234");

    // Delete a digit
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("backspace")))));
    await tester.pump();
    expect(value, "123");

    // Add Zero
    await tester.tap(find.byKey(const Key("btn0")));
    await tester.pump();
    expect(value, "1230");

    // Add decimal
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("specialKey")))));
    await tester.pump();
    expect(value, "1230.");

    await tester.tap(find.byKey(const Key("btn4")));
    await tester.pump();
    expect(value, "1230.4");
  });

  testWidgets('calls onCompleted when maxLength is reached',
      (WidgetTester tester) async {
    String result = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            CustomKeyBoard(
              maxLength: 4,
              onCompleted: (value) {
                result = value;
              },
              onChanged: (p0) {},
            ),
          ],
        ),
      ),
    );

    await tester.tap(find.text('1'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('4'));

    expect(result, equals('1234'));

    // Delete a digit
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("backspace")))));
    // Use the special . key
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("specialKey")))));
    await tester.pump();
    expect(result, "123.");

    // Delete a digit
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("backspace")))));
    // Tap 0 button
    await tester.tap(find.byKey(const Key("btn0")));
    expect(result, "1230");
  });
}

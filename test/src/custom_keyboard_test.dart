import 'package:custom_pin_screen/custom_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('custom keyboard is displayed ...', (tester) async {
    const length = 7;
    num? amount;
    await tester.pumpWidget(
      MaterialApp(
        home: Column(
          children: [
            CustomKeyBoard(
              key: const Key('keyboardKey'),
              maxLength: length,
              onChanged: (p0) {
                amount = num.tryParse(p0);
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
    assert(amount == 1234);

    // Delete a digit
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("backspace")))));
    await tester.pump();
    assert(amount == 123);

    // Add Zero
    await tester.tap(find.byKey(const Key("btn0")));
    await tester.pump();
    assert(amount == 1230);

    // Add decimal
    await tester.tap(
        find.byWidget(tester.firstWidget(find.byKey(const Key("specialKey")))));
    await tester.pump();
    assert(amount == 1230.0);
  });

  testWidgets(
      'custom keyboard throws exception when maxLenght is less than 0 or null...',
      (tester) async {
    expect(() => CustomKeyBoard(maxLength: -1), throwsAssertionError);
  });
}

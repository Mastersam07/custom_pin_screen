import 'package:custom_pin_screen/src/src.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('first pin code field color when  unselected ...',
      (tester) async {
    KeyBoardPinTheme theme =
        KeyBoardPinTheme(shape: PinCodeFieldShape.underline);
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: Row(
            children: <Widget>[
              for (int i = 0; i < 4; i++)
                PinCodeField(
                  key: Key('pinField$i'),
                  pinCodeFieldIndex: i,
                  theme: theme,
                  pin: '',
                ),
            ],
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // find first pin code field
    final fieldFinder = find.byKey(const Key('pinField0'));

    expect(fieldFinder, findsOneWidget);

    // assert that shape of pin field
    final pinField = tester.widget<PinCodeField>(fieldFinder);

    expect(pinField.theme.shape, equals(theme.shape));

    // find the animated container of pin field
    final containerFinder = find.descendant(
        of: fieldFinder, matching: find.byType(AnimatedContainer));

    expect(containerFinder, findsOneWidget);

    // check border color of first pin field when pin is empty
    final animContainer = tester.widget<AnimatedContainer>(containerFinder);
    final BoxDecoration animDecoration =
        animContainer.decoration as BoxDecoration;
    expect(
        animDecoration.color,
        equals(theme.shape == PinCodeFieldShape.underline
            ? Colors.transparent
            : pinField.getFillColorFromIndex));
  });
}

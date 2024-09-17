import 'package:flix/ui/widgets/form_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../ui_test_helper.dart';

main() {
  late Widget widgetUnderTest;
  late TextEditingController textEditingController;
  setUpAll(
    () {
      textEditingController = TextEditingController();
      widgetUnderTest = makeTestableWidget(
        child: Material(
          child: FormTextField(
            textEditingController,
            hintText: "Form hint",
            errorText: "Error text",
          ),
        ),
      );
    },
  );

  testWidgets("FormTextField inflation test with error and hint Text",
      (widgetTester) async {
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Form hint'), findsOneWidget);
    expect(find.text('Error text'), findsOneWidget);
  });

  testWidgets("Input Test", (widgetTester) async {
    await widgetTester.pumpWidget(widgetUnderTest);
    await widgetTester.pump();
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);
    await widgetTester.enterText(textFieldFinder, "testing");
    expect(find.text('testing'), findsOneWidget);
  });
}

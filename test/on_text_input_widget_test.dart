import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:on_text_input_widget/on_text_input_widget.dart';

void main() {
  group('OnTextInputWidget', () {
    testWidgets('renders with hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(hintText: 'Test hint'),
          ),
        ),
      );

      expect(find.text('Test hint'), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (
      WidgetTester tester,
    ) async {
      String changedValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              hintText: 'Input',
              onChanged: (String value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'hello');
      await tester.pump();

      expect(changedValue, 'hello');
    });

    testWidgets('shows prefix icon when provided', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('updates text via TextEditingController', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              controller: controller,
              hintText: 'Input',
            ),
          ),
        ),
      );

      controller.text = 'programmatic';
      await tester.pump();

      expect(find.text('programmatic'), findsOneWidget);
    });

    testWidgets('displays error when validator returns message', (
      WidgetTester tester,
    ) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                hintText: 'Email',
                validator: (String? value) {
                  if (value?.isEmpty ?? true) return 'Required field';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final bool isValid = formKey.currentState!.validate();
      await tester.pump();

      expect(isValid, isFalse);
      expect(find.text('Required field'), findsOneWidget);
    });

    testWidgets('validation failure preserves the entered text', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController(text: 'not-an-email');
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                controller: controller,
                hintText: 'Email',
                validator: (String? value) =>
                    value!.contains('@') ? null : 'Invalid email',
              ),
            ),
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();

      expect(controller.text, 'not-an-email');
    });

    testWidgets('errorBuilder renders without showDetailError', (
      WidgetTester tester,
    ) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                hintText: 'Input',
                validator: (String? value) => 'Always fails',
                errorBuilder: (String message) => Text('custom: $message'),
              ),
            ),
          ),
        ),
      );

      expect(formKey.currentState!.validate(), isFalse);
      await tester.pump();

      expect(find.text('custom: Always fails'), findsOneWidget);
    });

    testWidgets('does not show error for valid input', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController(text: 'valid@email.com');
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                controller: controller,
                hintText: 'Email',
                validator: (String? value) {
                  if (value?.isEmpty ?? true) return 'Required field';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final bool isValid = formKey.currentState!.validate();
      await tester.pump();

      expect(isValid, isTrue);
      expect(find.text('Required field'), findsNothing);
    });

    testWidgets('showDetailError displays error below the field', (
      WidgetTester tester,
    ) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                hintText: 'Input',
                showDetailError: true,
                validator: (String? value) {
                  if (value?.isEmpty ?? true) return 'Error below';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      final bool isValid = formKey.currentState!.validate();
      await tester.pump();

      expect(isValid, isFalse);
      //* Once in the visible section below the field, once in the built-in
      //* error text, which is rendered at zero size to carry semantics.
      expect(find.text('Error below'), findsNWidgets(2));
    });

    testWidgets('disabled field is not editable', (
      WidgetTester tester,
    ) async {
      String changedValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              hintText: 'Disabled',
              enabled: false,
              onChanged: (String value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'test');
      await tester.pump();

      expect(changedValue, isEmpty);
    });

    testWidgets('readOnly field blocks keyboard input', (
      WidgetTester tester,
    ) async {
      final TextEditingController controller =
          TextEditingController(text: 'readonly text');
      String changedValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              controller: controller,
              hintText: 'ReadOnly',
              readOnly: true,
              onChanged: (String value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'new text');
      await tester.pump();

      expect(changedValue, isEmpty);
    });

    testWidgets('maxLength limits character count', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              hintText: 'Limited',
              maxLength: 5,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), '1234567890');
      await tester.pump();

      final TextFormField textField =
          tester.widget<TextFormField>(find.byType(TextFormField));
      expect(textField.controller?.text.length, lessThanOrEqualTo(5));
    });

    testWidgets('onComplete triggers on editing complete', (
      WidgetTester tester,
    ) async {
      String completedValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              hintText: 'Complete',
              onComplete: (String? value) => completedValue = value ?? '',
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'done');
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();

      expect(completedValue, 'done');
    });
  });

  group('OnTextInputWidgetUserField', () {
    testWidgets('renders and shows hint text', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: OnTextInputWidgetUserField(hintText: 'Username'),
          ),
        ),
      );

      expect(find.text('Username'), findsOneWidget);
    });

    testWidgets('calls onChanged via UserField', (WidgetTester tester) async {
      String changedValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidgetUserField(
              hintText: 'Input',
              onChanged: (String value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'hello world');
      await tester.pump();

      expect(changedValue, 'hello world');
    });

    testWidgets('validates via UserField', (WidgetTester tester) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidgetUserField(
                hintText: 'Password',
                validator: (String? value) {
                  if (value?.isEmpty ?? true) return 'Password required';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Password required'), findsOneWidget);
    });

    testWidgets('toggles password visibility', (WidgetTester tester) async {
      final TextEditingController controller =
          TextEditingController(text: 'secret123');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidgetUserField(
              controller: controller,
              hintText: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      final Finder eyeToggle = find.byType(GestureDetector);
      await tester.tap(eyeToggle);
      await tester.pump();

      final EditableTextState state =
          tester.state<EditableTextState>(find.byType(EditableText));
      expect(state.widget.obscureText, isFalse);
    });
  });
}

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
              onChanged: (value) => changedValue = value,
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
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              textEditingController: controller,
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
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                hintText: 'Email',
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required field';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Required field'), findsOneWidget);
    });

    testWidgets('does not show error for valid input', (
      WidgetTester tester,
    ) async {
      final controller = TextEditingController(text: 'valid@email.com');
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                textEditingController: controller,
                hintText: 'Email',
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Required field';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Required field'), findsNothing);
    });

    testWidgets('showDetailError displays error below the field', (
      WidgetTester tester,
    ) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidget(
                hintText: 'Input',
                showDetailError: true,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Error below';
                  return null;
                },
              ),
            ),
          ),
        ),
      );

      formKey.currentState!.validate();
      await tester.pump();

      expect(find.text('Error below'), findsOneWidget);
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
              onChanged: (value) => changedValue = value,
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
      final controller = TextEditingController(text: 'readonly text');
      String changedValue = '';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidget(
              textEditingController: controller,
              hintText: 'ReadOnly',
              readOnly: true,
              onChanged: (value) => changedValue = value,
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

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
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
              onComplete: (value) => completedValue = value ?? '',
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
              onChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextFormField), 'hello world');
      await tester.pump();

      expect(changedValue, 'hello world');
    });

    testWidgets('validates via UserField', (WidgetTester tester) async {
      final formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Form(
              key: formKey,
              child: OnTextInputWidgetUserField(
                hintText: 'Password',
                validator: (value) {
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
      final controller = TextEditingController(text: 'secret123');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OnTextInputWidgetUserField(
              textEditingController: controller,
              hintText: 'Password',
              obscureText: true,
            ),
          ),
        ),
      );

      final eyeToggle = find.byType(GestureDetector);
      await tester.tap(eyeToggle);
      await tester.pump();

      final textField = tester.widget<TextFormField>(find.byType(TextFormField));
      final state = tester.state<EditableTextState>(find.byType(EditableText));
      expect(state.widget.obscureText, isFalse);
    });
  });
}

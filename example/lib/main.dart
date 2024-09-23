// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:example/custom_text_field1.dart';
import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';
import 'package:on_text_input_widget/on_text_input_widget.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  __OnChangedProcessing(),
                  __Validator(),
                  __LoginField(),
                  __MatchSize(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ______Space extends StatelessWidget {
  const ______Space();

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 8, width: 8);
  }
}

class ______Heading extends StatelessWidget {
  const ______Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ______Text extends StatelessWidget {
  const ______Text(this.text, {this.boldText = false});

  final String text;
  final bool boldText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: boldText ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}

class ______Details extends StatelessWidget {
  const ______Details({
    required this.heading,
    required this.text,
    required this.child,
    this.result = "",
  });

  final String heading;
  final String text;
  final Widget child;
  final String result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ______Heading("# $heading"),
        ______Text(text),
        child,
        if (result.isNotEmpty) Text("You searched for: $result"),
        ______Space(),
        ______Space(),
      ],
    );
  }
}

//! ------------------------------------------------------------------------------------------------ onChangedProcessing
class __OnChangedProcessing extends StatefulWidget {
  const __OnChangedProcessing();

  @override
  State<__OnChangedProcessing> createState() => __OnChangedProcessingState();
}

class __OnChangedProcessingState extends State<__OnChangedProcessing> {
  String result = "";

  @override
  Widget build(BuildContext context) {
    return ______Details(
      heading: "Search with a Onprogress Function",
      text: "You can use it to search an item from API. It will use time duration to search the last text input. So it will be efficient when searching something from Online server.\nUse \"onChanged\" to search offline.",
      result: result,
      child: OnTextInputWidget(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        showPrefixLoadingIcon: true,
        // showSuffixLoadingIcon: true,
        onChangedProcessing: (value) async {
          await Future.delayed(const Duration(seconds: 2));
          setState(() {
            result = value;
          });
        },
      ),
    );
  }
}

//! ------------------------------------------------------------------------------------------------ validator
class __Validator extends StatelessWidget {
  __Validator();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String v(String? value) {
    if (value?.isNotEmpty == true) {
      return "You entered username: $value";
    } else {
      return "Please enter your username";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          ______Details(
            heading: "Use as a Form Validator",
            text: "You can use it as a form validator. It will validate the text input when the user input something.\nIf error occurs, it will show the error message.",
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ______Text("Show Error inside of the box", boldText: true),
                OnTextInputWidget(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Email",
                  validator: v,
                ),
                ______Text("Show Error under the box", boldText: true),
                OnTextInputWidget(
                  prefixIcon: Icon(Icons.person),
                  hintText: "Email",
                  showDetailError: true, //?
                  validator: v,
                ),
              ],
            ),
          ),

          // Button
          OnProcessButtonWidget(
            onDone: (isSuccess) {
              _formKey.currentState?.validate();
            },
            child: Text("Press Me"),
          ),

          ______Space(),
          ______Space(),
        ],
      ),
    );
  }
}

//! ------------------------------------------------------------------------------------------------ LoginField
class __LoginField extends StatelessWidget {
  const __LoginField();

  @override
  Widget build(BuildContext context) {
    return ______Details(
        heading: "Example: Login Form",
        text: "Customize the textfield as Login Form. Just check the \"CustomTextField1\" example in the example folder.",
        child: Column(
          children: [
            // Username field
            CustomTextField1(
              keyboardType: TextInputType.emailAddress,
              hintText: "Enter your email",
              svg: "lib/assets/icons/message_icon.svg",
            ),
            ______Space(),
            // Password Field
            CustomTextField1(
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
              hintText: "Enter your password",
              svg: "lib/assets/icons/lock_icon.svg",
            ),
          ],
        ));
  }
}

class __MatchSize extends StatelessWidget {
  const __MatchSize();

  @override
  Widget build(BuildContext context) {
    return ______Details(
      heading: "Example: Same size as the Button",
      text: "Suitable to use it with \"OnProcessButtonWidget\" widget. Try it from the pub.dev.",
      child: Row(
        children: [
          // Input Field
          Flexible(child: OnTextInputWidget(borderRadius: BorderRadius.circular(0))),
          // ______Space(),

          // Button
          Flexible(
            child: OnProcessButtonWidget(
              borderRadius: BorderRadius.circular(0),
              backgroundColor: Colors.transparent,
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

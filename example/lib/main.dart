import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Center(
              child: OnTextInputWidget(
            
                minLines: 10,
                maxLines: 9,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

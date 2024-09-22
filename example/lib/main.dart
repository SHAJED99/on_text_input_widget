// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:on_process_button_widget/on_process_button_widget.dart';
import 'package:on_text_input_widget/on_text_input_widget.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    OnTextInputWidget(
                      prefixIcon: Icon(Icons.add_box),
                      showPrefixLoadingIcon: true,
                      boxConstraints: BoxConstraints(minHeight: 48),
                      fillColor: Colors.amber,
                      isDense: false,
                      isCollapsed: true,
                      textAlignVertical: TextAlignVertical(y: 0),
                      onChangedProcessing: (value) async {
                        await Future.delayed(Duration(seconds: 2));

                        print("0000 ___ $value");
                      },
                    ),
                    ______Space(),
                    Row(
                      children: [
                        Flexible(
                          child: OnTextInputWidget(
                            hintText: "Hello",
                            // showDetailError: true,
                            validator: (value) {
                              return "Press IT";
                            },
                          ),
                        ),
                        ______Space(),
                        Flexible(
                          child: OnProcessButtonWidget(
                            onDone: (_) {
                              _formKey.currentState?.validate();
                            },
                            child: Text("Okay"),
                          ),
                        ),
                      ],
                    ),
                    ______Space(),
                    Container(height: 24, color: Colors.amber)
                  ],
                ),
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

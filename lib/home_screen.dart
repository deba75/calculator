
import 'package:calculator_/widgets/buttonWidget.dart';
import 'package:calculator_/widgets/result.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/services.dart';


  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    String input = "";
    String result = "0";
    final FocusNode _focusNode = FocusNode();

    @override
    void dispose() {
      _focusNode.dispose();
      super.dispose();
    }

    void _handleKeyboardInput(RawKeyEvent event) {
      if (event is RawKeyDownEvent) {
        final key = event.data is RawKeyEventDataWindows
            ? (event.data as RawKeyEventDataWindows).keyLabel
            : event.character;
        if (key == null || key.isEmpty) return;
        setState(() {
          if (event.logicalKey == LogicalKeyboardKey.backspace) {
            if (input.isNotEmpty) {
              input = input.substring(0, input.length - 1);
            }
          } else if (event.logicalKey == LogicalKeyboardKey.delete) {
            input = "";
            result = "0";
          } else if (event.logicalKey == LogicalKeyboardKey.enter || key == '=') {
            if (input.isNotEmpty) {
              try {
                String expression = input.replaceAll('X', '*');
                result = _evaluateExpression(expression);
              } catch (e) {
                result = "Error";
              }
            }
          } else if (key == 'C' || key == 'c') {
            if (input.isNotEmpty) {
              input = input.substring(0, input.length - 1);
            }
          } else if (key == 'A' || key == 'a') {
            input = "";
            result = "0";
          } else if (RegExp(r'[0-9\+\-\*/\(\)\.]').hasMatch(key)) {
            // Prevent multiple operators in a row
            if (_isOperator(key)) {
              if (input.isEmpty || _isOperator(input[input.length - 1])) {
                return;
              }
            }
            input += key == '*' ? 'X' : key;
          }
        });
      }
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: const Text('Calculator', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
          backgroundColor: Colors.blueGrey[800],
          elevation: 0,
          centerTitle: true,
        ),
        body: RawKeyboardListener(
          focusNode: _focusNode,
          autofocus: true,
          onKey: _handleKeyboardInput,
          child: GestureDetector(
            onTap: () => _focusNode.requestFocus(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: resultWidget(userInput: input, result: result),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[800],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Buttonwidget(
                      onButtonPressed: (value) {
                        setState(() {
                          if (value == "AC") {
                            input = "";
                            result = "0";
                          } else if (value == "C") {
                            if (input.isNotEmpty) {
                              input = input.substring(0, input.length - 1);
                            }
                          } else if (value == "=") {
                            if (input.isNotEmpty) {
                              try {
                                String expression = input.replaceAll('X', '*');
                                result = _evaluateExpression(expression);
                              } catch (e) {
                                result = "Error";
                              }
                            }
                          } else {
                            // Prevent multiple operators in a row
                            if (_isOperator(value)) {
                              if (input.isEmpty || _isOperator(input[input.length - 1])) {
                                return;
                              }
                            }
                            input += value;
                          }
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    String _evaluateExpression(String expression) {
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        if (eval == eval.toInt()) {
          return eval.toInt().toString();
        }
        return eval.toString();
      } catch (e) {
        return "Error";
      }
    }

    bool _isOperator(String value) {
      return value == "+" || value == "-" || value == "/" || value == "X" || value == "*" || value == ".";
    }
  }

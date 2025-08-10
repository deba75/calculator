import 'package:flutter/material.dart';


class Buttonwidget extends StatelessWidget {
  final ValueChanged<String> onButtonPressed;
  const Buttonwidget({super.key, required this.onButtonPressed});

  static const List<String> buttonList = [
    "AC", "(", ")", "/",
    "7", "8", "9", "+",
    "4", "5", "6", "-",
    "1", "2", "3", "X",
    "C", "0", ".", "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        itemCount: buttonList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1.0,
        ),
        // Allow vertical scrolling if needed, but keep buttons compact
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return button(buttonList[index], context);
        },
      ),
    );
  }

  Color getcolor(String text) {
    if (text == "AC" || text == "+" || text == "(" || text == ")" || text == "-" || text == "/" || text == "X") {
      return Colors.red.shade700;
    }
    if (text == "C" || text == "=") {
      return Colors.white;
    }
    return Colors.blueGrey[900]!;
  }

  Color getbgcolor(String text) {
    if (text == "AC" || text == "C") {
      return Colors.indigo.shade400;
    }
    if (text == "+" || text == "-" || text == "/" || text == "X") {
      return Colors.indigo.shade700;
    }
    if (text == "=") {
      return Colors.green.shade600;
    }
    return Colors.white;
  }

  Widget button(String text, BuildContext context) {
    return SizedBox(
      height: 38,
      width: 38,
      child: ElevatedButton(
        onPressed: () {
          onButtonPressed(text);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: getbgcolor(text),
          foregroundColor: getcolor(text),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 1,
          shadowColor: Colors.black12,
          padding: EdgeInsets.zero,
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: getcolor(text),
            ),
          ),
        ),
      ),
    );
  }
}

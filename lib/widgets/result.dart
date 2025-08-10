import 'package:flutter/material.dart';


class resultWidget extends StatelessWidget {
  final String userInput;
  final String result;

  const resultWidget({super.key, required this.userInput, required this.result});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              userInput,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.black54,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 44,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}

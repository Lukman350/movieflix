import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String variant;
  final String text;
  final VoidCallback onPressed;

  const Button(
      {super.key,
      required this.variant,
      required this.text,
      required this.onPressed});

  final Color primary = const Color.fromARGB(255, 17, 14, 71);

  @override
  Widget build(BuildContext context) {
    return variant == 'primary'
        ? ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primary,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              textStyle: const TextStyle(
                letterSpacing: 1,
              ),
              shadowColor: Colors.black,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 229, 228, 234),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        : TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              foregroundColor: primary,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              side: const BorderSide(
                color: Color.fromARGB(255, 170, 169, 177),
                width: 1,
              ),
              textStyle: const TextStyle(
                letterSpacing: 1,
              ),
              shadowColor: Colors.black,
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromARGB(255, 170, 169, 177),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}

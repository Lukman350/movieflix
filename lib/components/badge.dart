import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const Badge({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 219, 227, 255),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: const Text(
          'New',
          style: TextStyle(
            color: Color.fromARGB(255, 136, 164, 232),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

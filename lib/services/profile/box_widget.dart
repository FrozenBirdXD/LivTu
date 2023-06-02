import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String subject;
  final double fontSize;
  const Box({super.key, required this.subject, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Text(
        subject,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
        ),
      ),
    );
  }
}



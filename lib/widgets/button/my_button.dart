import "package:flutter/material.dart";
import "package:flutter/services.dart";

class MyButton extends StatelessWidget {
  final String text;
  final Color color;
  VoidCallback onPressed;
  MyButton({super.key, required this.text, required this.color, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color,
      child: Text(text),  
    );
  }
}

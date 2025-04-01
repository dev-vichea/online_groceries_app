import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final Widget? suffixIcon;

  const MyTextField({
    super.key,
    required this.label,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, color: Colors.grey),
        suffixIcon: suffixIcon,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Widget? icon;
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;
  final String text;
  final Color? color, textColor;

  const MyButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.color,
    required this.padding,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          minimumSize: const Size(double.infinity, 55),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (icon != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: icon!,
                ),
              ),
            Text(text, style: TextStyle(fontSize: 16, color: textColor)),
          ],
        ),
      ),
    );
  }
}

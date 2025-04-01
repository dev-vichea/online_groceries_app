import 'package:flutter/material.dart';

class MyTransButton extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final void Function()? onPressed;
  final String text;
  final Color? textColor;

  const MyTransButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.padding,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onPressed,

        // style: TextButton.styleFrom(
        //   padding: EdgeInsets.zero,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   minimumSize: const Size(double.infinity, 55),
        // ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
        ),
      ),
    );
  }
}

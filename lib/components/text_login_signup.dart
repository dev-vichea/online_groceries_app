import 'package:flutter/material.dart';
import 'package:online_groceries_app/utils/constants.dart';

class RowTextLoginSignup extends StatelessWidget {
  final void Function()? onTap;
  final String firstText, secText;
  const RowTextLoginSignup({
    super.key,
    required this.firstText,
    required this.secText,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText),
        GestureDetector(
          onTap: onTap,
          child: Text(secText, style: TextStyle(color: kPrimaryColor)),
        ),
      ],
    );
  }
}
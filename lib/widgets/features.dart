import 'package:flutter/material.dart';
import 'package:online_groceries_app/utils/constants.dart';

class Feature extends StatelessWidget {
  final String text;
  const Feature({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefualtPaddin),
      margin: EdgeInsets.only(top: 18, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).colorScheme.tertiary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text('See all', style: TextStyle(fontSize: 16, color: kPrimaryColor)),
        ],
      ),
    );
  }
}
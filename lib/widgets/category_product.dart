import 'package:flutter/material.dart';
import 'package:online_groceries_app/model/groceries_model.dart';

class CategoryProduct extends StatelessWidget {
  final GroceriesModel groceries;
  const CategoryProduct({super.key, required this.groceries});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      width: 230,
      decoration: BoxDecoration(
        color: groceries.color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Image.asset(groceries.imgPath, width: 72),
          SizedBox(width: 15),
          Text(
            groceries.text,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
        ],
      ),
    );
  }
}

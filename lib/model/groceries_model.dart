import 'package:flutter/widgets.dart';

class GroceriesModel {
  final Color color;
  final String imgPath;
  final String text;

  GroceriesModel({
    required this.color,
    required this.imgPath,
    required this.text,
  });
}

List<GroceriesModel> groceries = [
  GroceriesModel(
    color: Color(0xFFfef2e4),
    imgPath: 'assets/images/pulses.png',
    text: 'Pulses',
  ),
  GroceriesModel(
    color: Color(0xFFe5f4ec),
    imgPath: 'assets/images/rice.png',
    text: 'Rice',
  ),
  GroceriesModel(
    color: Color(0xFFfde8e4),
    imgPath: 'assets/images/vegetables.png',
    text: 'Vegetables',
  ),
];
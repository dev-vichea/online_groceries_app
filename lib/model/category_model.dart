import 'package:flutter/material.dart';

class Category {
  final String name;
  final String imagePath;
  final Color bgColor;
  final Color borderColor;

  Category({
    required this.name,
    required this.imagePath,
    required this.bgColor,
    required this.borderColor,
  });
}

final List<Category> categories = [
  Category(
    name: 'Fresh Fruits & Vegetable',
    imagePath: 'assets/images/fruits-vegetable.png',
    bgColor: Color(0xff53B175).withAlpha(20),
    borderColor: Color(0xff53B175).withAlpha(90),
  ),
  Category(
    name: 'Cooking Oil & Ghee',
    imagePath: 'assets/images/oil-ghee.png',
    bgColor: Color(0xffF8A44C).withAlpha(20),
    borderColor: Color(0xffF8A44C).withAlpha(90),
  ),
  Category(
    name: 'Meat & Fish',
    imagePath: 'assets/images/meat-fish.png',
    bgColor: Color(0xffF7A593).withAlpha(20),
    borderColor: Color(0xffF7A593).withAlpha(90),
  ),
  Category(
    name: 'Bakery & Snacks',
    imagePath: 'assets/images/bakery-snacks.png',
    bgColor: Color(0xffD3B0E0).withAlpha(20),
    borderColor: Color(0xffD3B0E0).withAlpha(90),
  ),
  Category(
    name: 'Dairy & Eggs',
    imagePath: 'assets/images/dairy-egg.png',
    bgColor: Color(0xffFDE598).withAlpha(20),
    borderColor: Color(0xffFDE598).withAlpha(90),
  ),
  Category(
    name: 'Beverages',
    imagePath: 'assets/images/beverages.png',
    bgColor: Color(0xffB7DFF5).withAlpha(20),
    borderColor: Color(0xffB7DFF5).withAlpha(90),
  ),
  Category(
    name: 'Grain',
    imagePath: 'assets/images/grain.png',
    bgColor: Color(0xff836AF6).withAlpha(20),
    borderColor: Color(0xff836AF6).withAlpha(90),
  ),
  Category(
    name: 'Diet Food',
    imagePath: 'assets/images/diet-food.png',
    bgColor: Color(0xffD73B77).withAlpha(20),
    borderColor: Color(0xffD73B77).withAlpha(90),
  ),
];

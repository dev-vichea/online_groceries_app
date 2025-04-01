import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:online_groceries_app/utils/constants.dart';

class MyCarouselSlider extends StatelessWidget {
  final Function(int) onPageChanged; // Callback for page changes

  MyCarouselSlider({required this.onPageChanged, super.key});

  final List<String> images = [
    'assets/images/groceries-banner1.png',
    'assets/images/groceries-banner1.png',
    'assets/images/groceries-banner1.png',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        autoPlayCurve: Curves.fastOutSlowIn,
        animateToClosest: true,
        enlargeCenterPage: true,
        height: 100,
        onPageChanged: (index, reason) {
          onPageChanged(index);
        },
      ),
      items: images.map((img) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: kDefualtPaddin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(img, fit: BoxFit.cover, width: size.width),
          ),
        );
      }).toList(),
    );
  }
}

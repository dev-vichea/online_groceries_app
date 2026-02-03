import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_groceries_app/controllers/cart_controller.dart';
import 'package:online_groceries_app/controllers/favorite_controller.dart';
import 'package:online_groceries_app/controllers/theme_controller.dart';
import 'package:online_groceries_app/theme/theme.dart';
import 'package:online_groceries_app/views/main/onbording_screen.dart';

void main() {
  Get.put(CartController());
  Get.put(FavoriteController());
  Get.put(ThemeController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeController.themeMode.value,
        home: const OnbordingScreen(),
      ),
    );
  }
}

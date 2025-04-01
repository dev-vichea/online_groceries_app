import 'package:flutter/material.dart';
import 'package:online_groceries_app/provider/add_to_cart_provider.dart';
import 'package:online_groceries_app/provider/favorite_provider.dart';
import 'package:online_groceries_app/theme/theme.dart';
import 'package:online_groceries_app/theme/theme_provider.dart';
import 'package:online_groceries_app/views/main/onbording_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavoriteProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      home: OnbordingScreen(),
    );
  }
}

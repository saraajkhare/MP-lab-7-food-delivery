import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'theme.dart';
import 'home_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';

void main() {
  runApp(const MyRestaurantApp());
}

class MyRestaurantApp extends StatelessWidget {
  const MyRestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodExpress',
      theme: customTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => HomeScreen(),
        '/cart': (context) => CartScreen(),
        '/profile': (context) => ProfileScreen(),
      },
      home: SplashScreen(),
    );
  }
}

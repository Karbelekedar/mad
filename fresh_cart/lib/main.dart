import 'package:flutter/material.dart';
import 'package:fresh_cart/screens/auth_screen.dart';
import 'package:fresh_cart/screens/home_screen.dart';
import 'package:fresh_cart/screens/grocery_details_screen.dart';
import 'package:fresh_cart/screens/cart_screen.dart';
import 'package:fresh_cart/screens/checkout_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
      routes: {
        '/home': (ctx) => const HomeScreen(),
        // '/admin-home': (ctx) => const AdminHomeScreen(),
        '/grocery-details': (ctx) => const GroceryDetailsScreen(),
        '/cart': (ctx) => const CartScreen(),
        '/checkout': (ctx) => const CheckoutScreen(),
      },
    );
  }
}

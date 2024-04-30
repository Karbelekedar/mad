import 'package:flutter/material.dart';
import 'package:fresh_cart/screens/admin_screen.dart';
import 'package:fresh_cart/screens/auth_screen.dart';
import 'package:fresh_cart/screens/home_screen.dart';
import 'package:fresh_cart/screens/grocery_details_screen.dart';
import 'package:fresh_cart/screens/cart_screen.dart';
import 'package:fresh_cart/screens/checkout_screen.dart';
import 'package:fresh_cart/screens/cart_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(),
      routes: {
        '/home': (ctx) => const HomeScreen(),
        '/admin-home': (ctx) => const AdminScreen(),
        '/grocery-details': (ctx) => const GroceryDetailsScreen(),
        '/cart': (ctx) => const CartScreen(),
        '/checkout': (ctx) => const CheckoutScreen(),
      },
    );
  }
}

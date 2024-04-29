import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: 5, // Replace with the actual number of items in the cart
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(
              'https://app-backend-06lr.onrender.com/grocery_image_$index.jpg',
              width: 50.0,
              height: 50.0,
              fit: BoxFit.cover,
            ),
            title: Text('Grocery Item $index'),
            subtitle: const Text('Rs.9.99'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: () {
                // Remove the item from the cart
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Item removed from cart'),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the checkout screen
            Navigator.pushNamed(context, '/checkout');
          },
          child: const Text('Proceed to Checkout'),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  Future<void> _addGroceryItem() async {
    final url = Uri.parse('https://app-backend-jo8j.onrender.com/groceries');
    final response = await http.post(
      url,
      body: json.encode({
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'imageUrl': _imageUrlController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Item added successfully
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Grocery item added')),
      );
      _nameController.clear();
      _priceController.clear();
      _imageUrlController.clear();
    } else {
      // Error occurred while adding item
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add grocery item')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin - Add Grocery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the grocery name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the image URL';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addGroceryItem();
                  }
                },
                child: const Text('Add Grocery'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

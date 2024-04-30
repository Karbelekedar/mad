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

  List<Map<String, dynamic>> _groceryItems = [];

  @override
  void initState() {
    super.initState();
    _fetchGroceryItems();
  }

  Future<void> _fetchGroceryItems() async {
    final url = Uri.parse('https://app-backend-jo8j.onrender.com/groceries');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      setState(() {
        _groceryItems = data.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to fetch grocery items');
    }
  }

  Future<void> _addGroceryItem() async {
    final url = Uri.parse('https://app-backend-jo8j.onrender.com/groceries');
    final response = await http.post(
      url,
      body: json.encode({
        'name': _nameController.text,
        'price': "${_priceController.text}",
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
      _fetchGroceryItems(); // Refresh the grocery items list
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
        title: const Text('Admin - Manage Groceries'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (context, index) {
                final item = _groceryItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('Rs.${item['price']}'),
                );
              },
            ),
          ),
          Padding(
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
        ],
      ),
    );
  }
}

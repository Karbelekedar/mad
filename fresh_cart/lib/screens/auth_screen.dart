import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isLogin = true;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email address';
    }
    if (!value.contains('@')) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = _isLogin
          ? Uri.parse('https://app-backend-jo8j.onrender.com/login')
          : Uri.parse('https://app-backend-jo8j.onrender.com/signup');
      final requestBody = {'email': _email, 'password': _password};
      final response = await http.post(
        url,
        body: json.encode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final user = data['user'];
        final isAdmin = user['email'] == 'admin@gmail.com' &&
            user['password'] == 'password';
        if (isAdmin) {
          Navigator.pushReplacementNamed(context, '/admin-home');
        } else {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else if (response.statusCode == 409) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User already exists. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        final errorMessage = _isLogin
            ? 'Invalid email or password. Please try again.'
            : 'Failed to sign up. Please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isLogin ? 'Login' : 'Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                  onSaved: (value) {
                    _email = value!;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: _validatePassword,
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(_isLogin ? 'Login' : 'Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(
                    _isLogin
                        ? 'Don\'t have an account? Sign up'
                        : 'Already have an account? Login',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

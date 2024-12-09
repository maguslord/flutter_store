import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

      final TextEditingController _cityController = TextEditingController();
        final TextEditingController _stateController = TextEditingController();
          final TextEditingController _houseController = TextEditingController();
            final TextEditingController _postalcodeController = TextEditingController();

  Future<void> signupUser() async {
    final apiUrl = 'http://4.240.59.10:8090/store/signup';

    // Prepare the data to be sent to the API
    final Map<String, dynamic> data = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'password': _passwordController.text,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phone': _phoneController.text,
      'dob': _dobController.text,
        'country' :   _countryController.text,
        'city'  :   _cityController.text,
        'state' :  _stateController.text,
        'house' :   _houseController.text,
        'postalCode':  _postalcodeController.text,
      'profilePicture': null, // You can handle file uploads if needed
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Signup successful!')),
        );
        Navigator.pop(context); // Go back to SplashScreen
      } else {
        final responseBody = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Signup failed: ${responseBody["message"]}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone'),
            ),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
            ),
           TextField(
              controller : _countryController , 
                decoration: const InputDecoration(labelText: 'name of country')
            ),

               TextField(
              controller : _stateController , 
                decoration: const InputDecoration(labelText: 'name of province')
            ),


             TextField(
              controller : _cityController , 
                decoration: const InputDecoration(labelText: 'name of city')
            ),


             TextField(
              controller : _houseController , 
                decoration: const InputDecoration(labelText: 'house number')
            ),

             TextField(
              controller : _postalcodeController , 
                decoration: const InputDecoration(labelText: 'Nearest postal code')
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: signupUser,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'class/products_detail.dart';

// Add to Cart Functionality
Future<void> addToCart(BuildContext context, Product product) async {
  try {
    // Retrieve user_id from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in.')),
      );
      return;
    }

    // API URL for adding to cart
    const apiUrl = 'http://4.240.59.10:8090/store/add'; // Replace with your API endpoint

    // Send POST request
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'product_id': product.id,
        'quantity': 1,
      }),
    );

    // Handle Response
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Item added to cart.')),
      );
    } else {
      final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  } catch (e) {
    // Handle exceptions
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('An error occurred: $e')),
    );
  }
}

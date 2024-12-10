import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
Future<List<Map<String, dynamic>>> fetchCartItems() async {
  const apiUrl = 'http://4.240.59.10:8090/store/cart/view'; // API Endpoint
  try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      throw 'User not logged in.';
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['cart'] as List;  // You correctly parse the data here.
      return items.cast<Map<String, dynamic>>();  // This returns the list of cart items.
    } else {
      final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
      throw error;
    }
  } catch (e) {
    throw 'Error fetching cart items: $e';
  }
}

Future<void> checkout(BuildContext context) async {
  const apiUrl = 'http://4.240.59.10:8090/store/cart/checkout'; // API Endpoint for checkout
  try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      throw 'User not logged in.';
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Checkout successful.')),
      );
    } else {
      final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
      throw error;
    }
  } catch (e) {
    throw 'Error during checkout: $e';
  }
}

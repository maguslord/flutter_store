import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> deleteProduct(BuildContext context, int productId) async {
  const apiUrl = 'http://4.240.59.10:8090/store/cart/product/remove'; // API Endpoint for deleting a product
  try {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      throw 'User not logged in.';
    }

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'user_id': userId, 'product_id': productId}),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product removed successfully.')),
      );
    } else {
      final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
      throw error;
    }
  } catch (e) {
    throw 'Error deleting product: $e';
  }
}

Future<void> deleteCart(BuildContext context) async {
  const apiUrl = 'http://4.240.59.10:8090/store/cart/clear'; // API Endpoint for deleting the cart
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
        const SnackBar(content: Text('Cart deleted successfully.')),
      );
    } else {
      final error = jsonDecode(response.body)['error'] ?? 'Unknown error';
      throw error;
    }
  } catch (e) {
    throw 'Error deleting cart: $e';
  }
}

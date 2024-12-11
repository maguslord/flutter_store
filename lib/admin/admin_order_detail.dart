import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class OrderDetailScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderDetailScreen({Key? key, required this.order}) : super(key: key);

  Future<void> updateOrderStatus(BuildContext context, int statusId) async {
  const apiUrl = 'http://4.240.59.10:8090/store/admin/order/change/status'; // Replace with actual API

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'order_id': order['order_id'], 'status_id': statusId}),
    );

    // Log the response for debugging
    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order status updated successfully.')),
      );
      Navigator.pop(context); // Go back after updating
    } else {
      // Handle unexpected responses
      final errorMessage = _extractErrorMessage(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $errorMessage')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

/// Extract error message from the response body
String _extractErrorMessage(String responseBody) {
  try {
    final decoded = jsonDecode(responseBody);
    return decoded['error'] ?? 'Unknown error occurred';
  } catch (e) {
    return responseBody; // Return raw response if not JSON
  }
}


  void showStatusPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Order Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Dispatch'),
                onTap: () => updateOrderStatus(context, 3),
              ),
              ListTile(
                title: const Text('Cancel Order'),
                onTap: () => updateOrderStatus(context, 5),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order ID: ${order['order_id']}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Order Date: ${order['order_date']}"),
            Text("Order Status: ${order['order_status']}"),
            Text("Total Price: \$${order['total_price']}"),
            Text("User Name: ${order['user_name']}"),
            Text("Email: ${order['email']}"),
            Text("Phone: ${order['user_email']}"),
            const SizedBox(height: 20),
            Text("Order Details:\n${order['order_details']}"),
            const Spacer(),
            ElevatedButton(
              onPressed: () => showStatusPopup(context),
              child: const Text('Change Status'),
            ),
          ],
        ),
      ),
    );
  }
}

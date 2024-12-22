import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '/class/products_detail.dart';

class AdminProductDetailsPage extends StatefulWidget {
  final Product product;

  AdminProductDetailsPage({required this.product});

  @override
  _AdminProductDetailsPageState createState() =>
      _AdminProductDetailsPageState();
}

class _AdminProductDetailsPageState extends State<AdminProductDetailsPage> {
  final TextEditingController _quantityController = TextEditingController();
  bool isQuantityEnabled = false;
  bool isAddButtonEnabled = false;

  // Function to call the API to add quantity
  Future<void> addProductQuantity(int productId, int quantity) async {
    const apiUrl = 'http://4.240.59.10:8090/admin/add-quantity';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'product_id': productId, 'quantity': quantity}),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quantity added successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add quantity: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 100,
                    ),
                  );
                },
              ),
            ),
            // Product Details
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Remaining Quantity: ${product.quantity.toString()}',
                    style: const TextStyle(fontSize: 19),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Supplier: ${product.supplierName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${product.categoryName}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  // Quantity Input Section
                  Row(
                    children: [
                      // Quantity Input Field
                      Expanded(
                        child: TextField(
                          controller: _quantityController,
                          enabled: isQuantityEnabled,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Quantity',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              // Ensure only valid integers are accepted
                              isAddButtonEnabled = int.tryParse(value) != null &&
                                  int.parse(value) > 0;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Enable Button
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isQuantityEnabled = true;
                          });
                        },
                        child: const Text('Enable'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Add Quantity Button
                  ElevatedButton(
                    onPressed: isAddButtonEnabled
                        ? () async {
                            final quantity = int.parse(_quantityController.text);
                            await addProductQuantity(product.id, quantity);
                            setState(() {
                              isQuantityEnabled = false;
                              isAddButtonEnabled = false;
                              _quantityController.clear();
                            });
                          }
                        : null,
                    child: const Text('Add Quantity'),
                  ),
                  // Warning Message
                  if (!isAddButtonEnabled)
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Add button disabled until valid quantity is entered.',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

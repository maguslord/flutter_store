import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'ProductDetailsPage.dart'; // Assuming you have a product details page
import 'class/products_detail.dart'; // Assuming you have a Product model

class AdvancedSearchPage extends StatefulWidget {
  @override
  _AdvancedSearchPageState createState() => _AdvancedSearchPageState();
}

class _AdvancedSearchPageState extends State<AdvancedSearchPage> {
  List<dynamic> _suppliers = [];
  List<dynamic> _categories = [];
  String? _selectedSupplier;
  String? _selectedCategory;
  String _productName = "";
  List<Product> _products = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
    _fetchCategories();
  }

  // Fetch Suppliers from the API
  Future<void> _fetchSuppliers() async {
    final response = await http.get(Uri.parse('http://4.240.59.10:8090/store/suppliers'));
    if (response.statusCode == 200) {
      setState(() {
        _suppliers = jsonDecode(response.body);
      });
    } else {
      print("Failed to load suppliers");
    }
  }

  // Fetch Categories from the API
  Future<void> _fetchCategories() async {
    final response = await http.get(Uri.parse('http://4.240.59.10:8090/store/categories'));
    if (response.statusCode == 200) {
      setState(() {
        _categories = jsonDecode(response.body);
      });
    } else {
      print("Failed to load categories");
    }
  }

  // Perform Product Search
  void _searchProducts() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://4.240.59.10:8090/store/products/search'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'product_name': _productName.isEmpty ? null : _productName,
        'supplier_id': _selectedSupplier != null ? int.parse(_selectedSupplier!) : null,
        'category_id': _selectedCategory != null ? int.parse(_selectedCategory!) : null,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _products = data.map<Product>((item) => Product.fromJson(item)).toList();
      });
    } else {
      print('Error searching products');
    }

    setState(() {
      _isLoading = false;
    });
  }

  // Reset filters (clear selected supplier and category)
  void _resetFilters() {
    setState(() {
      _selectedSupplier = null;
      _selectedCategory = null;
      _productName = "";
      _products = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Advanced Product Search')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Product Name Search
            TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
              onChanged: (value) {
                setState(() {
                  _productName = value;
                });
              },
            ),
            // Supplier Dropdown
            DropdownButton<String>(
              value: _selectedSupplier,
              hint: Text('Select Supplier'),
              onChanged: (value) {
                setState(() {
                  _selectedSupplier = value;
                });
              },
              items: _suppliers.map((supplier) {
                return DropdownMenuItem<String>(
                  value: supplier['supplier_id'].toString(),
                  child: Text(supplier['supplier_name']),
                );
              }).toList(),
            ),
            // Category Dropdown
            DropdownButton<String>(
              value: _selectedCategory,
              hint: Text('Select Category'),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['category_id'].toString(),
                  child: Text(category['category_name']),
                );
              }).toList(),
            ),
            // Search Button
            ElevatedButton(
              onPressed: _searchProducts,
              child: Text('Search'),
            ),
            // Reset Filters Button
            ElevatedButton(
              onPressed: _resetFilters,
              child: Text('Reset Filters'),
            ),
            // Loading Indicator
            if (_isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator())),
            // Show Products After Search
            if (!_isLoading && _products.isEmpty)
              const Expanded(
                child: Center(child: Text('No products found. Start searching!')),
              ),
            // Display Products in Grid
            if (!_isLoading && _products.isNotEmpty)
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsPage(product: product),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.network(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return const Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(
                                    Icons.broken_image,
                                    size: 80,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '\$${product.price.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AddStockScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Stock'),
      ),
      body: const Center(
        child: Text(
          'Add Stock Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

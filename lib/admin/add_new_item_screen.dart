import 'package:flutter/material.dart';

class AddNewItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: const Center(
        child: Text(
          'Add New Item Screen',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

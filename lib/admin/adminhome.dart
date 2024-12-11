import 'package:flutter/material.dart';
import 'pending_orders_screen.dart';
import 'add_stock_screen.dart';
import 'add_new_item_screen.dart';
import 'check_stock_screen.dart';
import 'package:smdb/search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildCard(
            context,
            'Pending Orders',
            Colors.blue,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PendingOrdersScreen()),
            ),
          ),
          _buildCard(
            context,
            'Add Stock',
            Colors.green,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStockScreen()),
            ),
          ),
          _buildCard(
            context,
            'Add New Item',
            Colors.orange,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddNewItemScreen()),
            ),
          ),
          _buildCard(
            context,
            'Check Stock',
            const Color.fromARGB(255, 47, 126, 23),
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CheckStockScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(
    BuildContext context,
    String title,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

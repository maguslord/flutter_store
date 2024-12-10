import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CartPage.dart';
import 'OrdersPage.dart'; // Import OrdersPage

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  int? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getInt('userId'); // Retrieve the stored userId
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator()) // Loading
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'Welcome, User!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text('View Cart'),
                  leading: const Icon(Icons.shopping_cart),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  title: const Text('View Orders'),
                  leading: const Icon(Icons.receipt),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrdersPage(userId: userId!), // Pass userId
                      ),
                    );
                  },
                ),
              ],
            ),
    );
  }
}

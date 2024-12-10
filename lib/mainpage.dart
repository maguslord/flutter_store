import 'package:flutter/material.dart';
import 'splash_screen.dart' ;
import'admin/adminlogin.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the Customer Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SplashScreen()),
                );
              },
              child: const Text('Customer'),
            ),
            const SizedBox(height: 20), // Add some spacing between the buttons
            ElevatedButton(
              onPressed: () {
                // Navigate to the Admin Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: const Text('Admin'),
            ),
          ],
        ),
      ),
    );
  }
}


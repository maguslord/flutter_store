import 'package:flutter/material.dart';
import 'home.dart';
import 'search.dart';
import 'user.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Determine which screen to show based on currentIndex
    Widget selectedScreen;
    if (currentIndex == 0) {
      selectedScreen = ProductListPage();
    } else if (currentIndex == 1) {
      selectedScreen = Search();
    } else {
      selectedScreen = User();
    }

    return Scaffold(
      body: selectedScreen, // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        iconSize: 30,
        onTap: (int index) {
          // Update state and re-build the widget
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

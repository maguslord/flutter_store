import 'package:flutter/material.dart';
import 'bottom_nav_bar.dart';
import 'splash_screen.dart';
import 'mainpage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false ,
      
     // home: SplashScreen(),
     home : MainPage() ,
    );
  }
}




import 'package:baitap/models/cart.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Cart cart = Cart();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(cart: cart),
      debugShowCheckedModeBanner: false,
    
    );
  }
}

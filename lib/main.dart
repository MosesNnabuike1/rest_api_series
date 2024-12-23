import 'package:flutter/material.dart';
import 'package:rest_api_series/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue, // Sets the primary color to blue
      ),
      home: const HomeScreen(),
    );
  }
}

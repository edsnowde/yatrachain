import 'package:flutter/material.dart';
import 'main_screen.dart'; // Import your MainScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'YatraChain',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const MainScreen(), // ✅ IMPORTANT
    );
  }
}

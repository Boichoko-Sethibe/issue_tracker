import 'package:flutter/material.dart';
import 'package:issue_tracker/Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Issue Tracker",home: HomeScreen(),);
  }
}
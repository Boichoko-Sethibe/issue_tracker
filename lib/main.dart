import 'package:flutter/material.dart';
import 'package:issue_tracker/Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryIconTheme: const IconThemeData(color: Colors.blue),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.blue,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      title: "Issue Tracker",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

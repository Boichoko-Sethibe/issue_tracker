import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:issue_tracker/Class/issue_manager.dart';
import 'package:issue_tracker/Screens/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IssueManager().init();
  runApp(
    ChangeNotifierProvider(
      create: (_) => IssueManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Issue Tracker",
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

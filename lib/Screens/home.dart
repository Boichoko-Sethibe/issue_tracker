import 'package:flutter/material.dart';
import 'package:issue_tracker/Screens/add_issue.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Main Screen"),
            SizedBox(height: 100),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddIssue()),
                );
              },
              child: Text("Add Issue"),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:issue_tracker/Screens/add_issue.dart';
import 'package:issue_tracker/Screens/issues.dart';
import 'package:issue_tracker/Screens/resolved_issues.dart';

// import '../Class/issue.dart';

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
            SizedBox(height: 200),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewIssues(),
                  ),
                );
              },
              child: Text("View Issues"),
            ),
            SizedBox(height: 200),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResolvedIssues(),
                  ),
                );
              },
              child: Text("View Resolved Issues"),
            )
          ],
        ),
      ),
    );
  }
}

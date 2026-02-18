import 'package:flutter/material.dart';

class ResolvedIssues extends StatefulWidget {
  const ResolvedIssues({super.key});

  @override
  State<ResolvedIssues> createState() => _ResolvedIssuesState();
}

class _ResolvedIssuesState extends State<ResolvedIssues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text("Resolved Issues Screen"),
          SizedBox(height: 100),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go Back"),
          ),
        ],
      ),),
    );
  }
}
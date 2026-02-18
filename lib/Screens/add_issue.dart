import 'package:flutter/material.dart';

class AddIssue extends StatefulWidget {
  const AddIssue({super.key});

  @override
  State<AddIssue> createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text("Add Issue Screen"),
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
import 'package:flutter/material.dart';

class ViewIssues extends StatefulWidget {
  const ViewIssues({super.key});

  @override
  State<ViewIssues> createState() => _ViewIssuesState();
}

class _ViewIssuesState extends State<ViewIssues> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Text("View Issues Screen"),
          SizedBox(height: 100),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Go Back"),
          ),],
      ),),
    );
  }
}
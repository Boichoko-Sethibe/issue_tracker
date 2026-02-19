import 'package:flutter/material.dart';
import 'package:issue_tracker/Class/issue.dart';
import 'package:issue_tracker/Class/issue_manager.dart';
import 'package:issue_tracker/Screens/issues.dart';

class AddIssue extends StatefulWidget {
  const AddIssue({super.key});

  @override
  State<AddIssue> createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  final Issue _issue = Issue();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitIssue() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    _issue.title = _titleController.text;
    _issue.description = _descriptionController.text;

    IssueManager().addIssue(_issue);

    Navigator.push(context, MaterialPageRoute(builder: (context) => ViewIssues()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Form(key: _formKey,
            child:   Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: "Issue Subject"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an issue subject';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: "Issue Description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an issue description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitIssue,
                child: Text("Submit Issue"),
              ),
            ],
          ),),
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
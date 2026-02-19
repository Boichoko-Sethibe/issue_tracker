import 'package:flutter/material.dart';
import 'package:issue_tracker/Class/issue.dart';
import 'package:issue_tracker/Class/issue_manager.dart';

class ViewIssues extends StatefulWidget {
  const ViewIssues({super.key});

  @override
  State<ViewIssues> createState() => _ViewIssuesState();
}

class _ViewIssuesState extends State<ViewIssues> {
  List<Issue> get _issues => IssueManager().issues;

  void _changeStatusDialog(int index) {
    String selected = _issues[index].status;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Status'),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return DropdownButton<String>(
                value: selected,
                items: ['Open', 'In Progress', 'Resolved']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (v) {
                  if (v != null) setStateDialog(() => selected = v);
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _issues[index].status = selected;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteIssueDialog(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Issue'),
          content: Text('Are you sure you want to delete this issue?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  IssueManager().issues.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final issues = _issues;

    return Scaffold(
      appBar: AppBar(title: Text('Issues')),
      body: Center(
        child: issues.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('No issues submitted yet.'),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Go Back'),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: issues.length,
                itemBuilder: (context, index) {
                  final issue = issues[index];
                  return ListTile(
                    title: Text('Issue Title: ${issue.title}'),
                    subtitle: Text(issue.description),
                    trailing: Text('Status: ${issue.status}'),
                    onTap: () => _changeStatusDialog(index),
                    onLongPress: () => _deleteIssueDialog(index),
                  );
                },
              ),
      ),
    );
  }
}
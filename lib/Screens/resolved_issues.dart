import 'package:flutter/material.dart';
import 'package:issue_tracker/Class/issue.dart';
import 'package:issue_tracker/Class/issue_manager.dart';

class ResolvedIssues extends StatefulWidget {
  const ResolvedIssues({super.key});

  @override
  State<ResolvedIssues> createState() => _ResolvedIssuesState();
}

class _ResolvedIssuesState extends State<ResolvedIssues> {
  void _deleteIssueDialog(Issue issue) {
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
                  IssueManager().issues.remove(issue);
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
    final resolvedIssues = IssueManager().issues.where((issue) => issue.status == "Resolved").toList();
    return Scaffold(
      body: Center(
        child: resolvedIssues.isEmpty
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('No issues resolved yet.'),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Go Back'),
                  ),
                ],
              )
            : ListView.builder(
                itemCount: resolvedIssues.length,
                itemBuilder: (context, index) {
                  final issue = resolvedIssues[index];
                  return ListTile(
                    title: Text('Issue Title: ${issue.title}'),
                    subtitle: Text(issue.description),
                    trailing: Text('Status: ${issue.status}'),
                    onLongPress: () => _deleteIssueDialog(issue),
                  );
                },
              ),
      ),
    );
  }
}
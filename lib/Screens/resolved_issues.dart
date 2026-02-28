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
                  IssueManager().removeIssue(issue);
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
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Resolved Issues"),backgroundColor: Colors.blue,),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: resolvedIssues.isEmpty
              ? Column(
                  key: ValueKey('emptyResolved'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('No issues resolved yet.'),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Go Back'),
                    ),
                  ],
                )
              : ListView.builder(
                  key: ValueKey('resolvedList'),
                  itemCount: resolvedIssues.length,
                  itemBuilder: (context, index) {
                    final issue = resolvedIssues[index];
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text('Issue Title: ${issue.title}'),
                        subtitle: Text(issue.description),
                        trailing: Text('Status: ${issue.status}'),
                        leading: Text(issue.dateCreated.toLocal().toIso8601String().split('T')[0]),
                        onLongPress: () => _deleteIssueDialog(issue),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
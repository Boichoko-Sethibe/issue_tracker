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
                  IssueManager().updateStatus(index, selected);
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
                  IssueManager().removeAt(index);
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
    final issues = _issues.where( (issue) => issue.status == "Open" || issue.status == "In Progress").toList();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Issues"),backgroundColor: Colors.blue,),
      body: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: issues.isEmpty
              ? Column(
                  key: ValueKey('empty'),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('No issues submitted yet.'),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Go Back'),
                    ),
                  ],
                )
              : ListView.builder(
                  key: ValueKey('list'),
                  itemCount: issues.length,
                  itemBuilder: (context, index) {
                    final issue = issues[index];
                    Color bgColor;
                    switch (issue.status) {
                      case 'In Progress':
                        bgColor = Colors.orange.shade50;
                        break;
                      case 'Resolved':
                        bgColor = Colors.green.shade50;
                        break;
                      default:
                        bgColor = Colors.white;
                    }
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: bgColor,
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
                        onTap: () => _changeStatusDialog(index),
                        onLongPress: () => _deleteIssueDialog(index),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
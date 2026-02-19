import 'package:issue_tracker/Class/issue.dart';

class IssueManager {
  IssueManager._internal();
  static final IssueManager _instance = IssueManager._internal();
  factory IssueManager() => _instance;

  final List<Issue> _issues = [];

  List<Issue> get issues => List.unmodifiable(_issues);

  void addIssue(Issue issue) {
    _issues.add(issue);
  }
}

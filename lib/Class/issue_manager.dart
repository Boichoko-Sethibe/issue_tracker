import 'package:issue_tracker/Class/issue.dart';

class IssueManager {
  IssueManager._internal();
  static final IssueManager _instance = IssueManager._internal();
  factory IssueManager() => _instance;

  final List<Issue> _issues = [];

  List<Issue> get issues => List.unmodifiable(_issues);

  void addIssue(Issue issue) {
    _issues.add(issue);
    _issues.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
  }

  // Mutator methods to keep internal list encapsulated while allowing
  // controlled modifications from UI code.
  void removeAt(int index) {
    if (index >= 0 && index < _issues.length) {
      _issues.removeAt(index);
    }
  }

  void removeIssue(Issue issue) {
    _issues.remove(issue);
  }

  void updateStatus(int index, String status) {
    if (index >= 0 && index < _issues.length) {
      _issues[index].status = status;
    }
  }
}

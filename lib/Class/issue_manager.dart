import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:issue_tracker/Class/issue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IssueManager extends ChangeNotifier {
  IssueManager._internal();
  static final IssueManager _instance = IssueManager._internal();
  factory IssueManager() => _instance;

  static const _prefsKey = 'issues';

  final List<Issue> _issues = [];

  List<Issue> get issues => List.unmodifiable(_issues);

  /// Initialize from local storage. Call this before `runApp`.
  Future<void> init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey);
      if (raw != null && raw.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(raw) as List<dynamic>;
        _issues
          ..clear()
          ..addAll(decoded.map((e) => Issue.fromJson(e as Map<String, dynamic>)));
        _issues.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
        notifyListeners();
      }
    } catch (_) {
      // ignore errors reading prefs
    }
  }

  void addIssue(Issue issue) {
    _issues.add(issue);
    _issues.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    _saveToPrefs();
    notifyListeners();
  }

  // Mutator methods to keep internal list encapsulated while allowing
  // controlled modifications from UI code.
  void removeAt(int index) {
    if (index >= 0 && index < _issues.length) {
      _issues.removeAt(index);
      _saveToPrefs();
      notifyListeners();
    }
  }

  void removeIssue(Issue issue) {
    _issues.remove(issue);
    _saveToPrefs();
    notifyListeners();
  }

  void updateStatus(int index, String status) {
    if (index >= 0 && index < _issues.length) {
      _issues[index].status = status;
      _saveToPrefs();
      notifyListeners();
    }
  }

  Future<void> _saveToPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(_issues.map((e) => e.toJson()).toList());
      await prefs.setString(_prefsKey, encoded);
    } catch (_) {
      // ignore save errors
    }
  }
}

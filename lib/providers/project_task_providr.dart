import 'package:flutter/material.dart';
import 'package:time_tracker/models/models.dart';


class TimeEntryProvider with ChangeNotifier {
  final List<TimeEntry> _entries = [];

  List<TimeEntry> get entries => _entries;

  void addTimeEntry(TimeEntry entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteTimeEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }
}

class ProjectEntryProvider with ChangeNotifier {
  final List<Project> _entries = [];

  List<Project> get entries => _entries;

  List<String> projectNames() {
    return _entries.map((entry) => entry.name).toList();
  }
  void addProjectEntry(Project entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteProjectEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }
}
class TaskEntryProvider with ChangeNotifier {
  final List<Task> _entries = [];

  List<Task> get entries => _entries;

  List<String> taskNames() {
    return _entries.map((entry) => entry.name).toList();
  }
  void addTaskEntry(Task entry) {
    _entries.add(entry);
    notifyListeners();
  }

  void deleteTaskEntry(String id) {
    _entries.removeWhere((entry) => entry.id == id);
    notifyListeners();
  }
}
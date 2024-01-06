import 'package:flutter/material.dart';
import 'package:map_exam/common/models/models.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  bool _expanded = true;
  dynamic _showingTool;

  List<Note> get notes => _notes;
  int get count => _notes.length;
  bool get expanded => _expanded;
  dynamic get showingTool => _showingTool;

  void updateNotes(List<Note> data) {
    _notes.clear();
    _notes.addAll(data);
    notifyListeners();
  }

  void updateExpanded(bool data) {
    _expanded = data;
    notifyListeners();
  }

  void toggleToolVisibility(dynamic key) {
    _showingTool = key;
    notifyListeners();
  }
}

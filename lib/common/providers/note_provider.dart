import 'package:flutter/material.dart';
import 'package:map_exam/common/models/models.dart';

class NoteProvider extends ChangeNotifier {
  final List<Note> _notes = [];
  bool _expanded = true;

  List<Note> get notes => _notes;
  int get count => _notes.length;

  bool get expanded => _expanded;

  void updateNotes(List<Note> data) {
    _notes.clear();
    _notes.addAll(data);
    notifyListeners();
  }

  void updateExpanded(bool data) {
    _expanded = data;
    notifyListeners();
  }
}


import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';


class NotesProvider with ChangeNotifier {
  List<String> selectedNotes = [];
  List<String> notes = [];

  void toggleNoteSelection(String noteId) {
    if (selectedNotes.contains(noteId)) {
      selectedNotes.remove(noteId);
    } else {
      selectedNotes.add(noteId);
    }
    notifyListeners();
  }

  void selectAllNotes(List<String> noteIds) {
    selectedNotes.addAll(noteIds);
    notifyListeners();
  }

  void clearSelection() {
    selectedNotes.clear();
    notifyListeners();
  }

  void setNotes(List<String> newNotes) {
    notes = newNotes;
    notifyListeners();
  }
}



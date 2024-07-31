import 'dart:convert';

import 'package:get/get.dart';
import 'package:notes_app/models/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NoteController extends GetxController {
  List<Note> notes = <Note>[].obs;
  var _idCounter = 0;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? noteString = prefs.getString('notes');
      if (noteString != null) {
        final List<dynamic> noteJson = jsonDecode(noteString);
        notes.assignAll(noteJson.map((json) => Note.fromJson(json)).toList());
        if (notes.isEmpty) {
          _idCounter =
              notes.map((note) => note.id).reduce((a, b) => a > b ? a : b) + 1;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveNotes() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String noteString =
          jsonEncode(notes.map((note) => note.toJson).toList());
      await prefs.setString('notes', noteString);
    } catch (e) {
      print(e);
    }
  }

  addNote(String description) {
    notes.add(Note(id: _idCounter++, description: description));
    saveNotes();
    update();
  }

  deleteNote(int id) {
    notes.removeWhere((note) => note.id == id);
    saveNotes();
    update();
  }

  changeStatus(Note note) {
    int index = notes.indexOf(note);
    notes[index].isCompleted = !notes[index].isCompleted;
    update();
  }

  printNotes() {
    print("Notes List:");
    for (var note in notes) {
      print(
          "ID: ${note.id}, Description: ${note.description}, Completed: ${note.isCompleted}");
    }
  }
}

import 'package:hive/hive.dart';

class NoteHelper {
  static var noteBox = "NoteBox";
  static var noteKey = "noteKey";

  static List<String> notes = [];

  static void addNote(String noteText) {
    notes.add(noteText);
    Hive.box(noteBox).put(noteKey, notes);
  }

  static void updateNote(String noteText, int i) {
    notes[i] = noteText;
    Hive.box(noteBox).put(noteKey, notes);
  }

  static void deleteNote(int i) {
    notes.removeAt(i);
    Hive.box(noteBox).put(noteKey, notes);
  }

  static void deleteAllNote() {
    notes.clear();
    Hive.box(noteBox).put(noteKey, notes);
  }

  static Future<void> getAllNote() async {
    var box = Hive.box(noteBox);

    notes = box
        .get(noteKey, defaultValue: <String>[])!
        .cast<String>();
  }
  //static Future<void> getAllNote() async {
//     notes = await Hive.box(noteBox).get(noteKey);
//   }
}





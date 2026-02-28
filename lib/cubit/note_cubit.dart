import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../hive_helper/hive_helper.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void getNotes() async {
    emit(NoteLoadingState());
    await NoteHelper.getAllNote();
    emit(NoteSuccessState());
  }

  void addNote(String text) {
    NoteHelper.addNote(text);
    emit(NoteSuccessState());
  }

  void updateNote({required String text, required int i}) {
    NoteHelper.updateNote(text, i);
    emit(NoteSuccessState());
  }

  void deleteAllNotes() {
    NoteHelper.deleteAllNote();
    emit(NoteSuccessState());
  }

  void deleteNote(int i) {
    NoteHelper.deleteNote(i);
    emit(NoteSuccessState());
  }
}
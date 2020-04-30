import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

class NotesItemViewModel extends BaseViewModel {
  String heroTag = 'note-${randomString(20)}';

  NotesItemViewModel();
  
  FocusNode focusNode = FocusNode();
  TextEditingController noteController = TextEditingController();

  void init(NoteModel item) {
    if (item == null) return;
    noteController.text = item.text;
    heroTag = item.heroTag;
  }

  void saveNote() {
    String title = noteController.text;
    if (title.length > 70) {
      title = title.substring(0, 70);
      title += '...';
    }
    print(title);
    NoteModel newNote = NoteModel(title, DateTime.now().toString(), noteController.text, 'no', heroTag);
    navigation.pop(newNote);
  }
  
  void focusInput() {
    focusNode.requestFocus();
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  @override
  void dispose() {
    focusNode.dispose();
    noteController.dispose();
    super.dispose();
  }
}
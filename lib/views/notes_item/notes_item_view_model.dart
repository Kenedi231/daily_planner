import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

class NotesItemViewModel extends BaseViewModel {
  String heroTag = 'note-${randomString(20)}';

  List<String> categories = ['Work', 'Life', 'Personal', 'No category'];
  String currentValue = 'No category';

  set setCurrentValue(String value) {
    currentValue = value;
    notifyListeners();
  }

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
    }
    print(title);
    NoteModel newNote = NoteModel(title, DateTime.now().toString(), noteController.text, null, heroTag);
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
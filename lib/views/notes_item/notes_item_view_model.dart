import 'package:app_list/core/base/base_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class NotesItemViewModel extends BaseViewModel {
  NotesItemViewModel();
  
  FocusNode focusNode = FocusNode();
  TextEditingController noteController = TextEditingController();

  void saveNote() {
    navigation.pop(noteController.text);
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
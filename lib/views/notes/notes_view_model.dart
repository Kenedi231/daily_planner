import 'package:app_list/core/base/base_view_model.dart';

class NotesViewModel extends BaseViewModel {
  NotesViewModel();
  
  void createNewNotes() async {
    var item = await navigation.navigateToNotesItem();
    print(item);
  }
}
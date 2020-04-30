import 'dart:convert';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:flutter/cupertino.dart';

class NotesViewModel extends BaseViewModel {
  NotesViewModel();

  String key = 'notes_list';

  List<NoteModel> listNotes = List<NoteModel>();
  GlobalKey<AnimatedListState> noteListKey = GlobalKey<AnimatedListState>();

  void init() {
    listNotes.clear();
    List<dynamic> todoListString = storageService.getItem(key);
    if (todoListString == null) return;
    for (var item in todoListString) {
      listNotes.add(NoteModel.fromJson(jsonDecode(item)));
    }
    notifyListeners();
  }
  
  void createNewNotes() async {
    NoteModel item = await navigation.navigateToNotesItem(null);
    if (item == null) return;
    listNotes.add(item);
    noteListKey.currentState.insertItem(listNotes.length - 1, duration: Duration(microseconds: 0));
    notifyListeners();
    saveToStorage();
  }

  void editItem(NoteModel data) async {
    var index = listNotes.indexOf(data);
    NoteModel item = await navigation.navigateToNotesItem(listNotes[index]);
    if (item == null) return;
    listNotes[index] = item;
    notifyListeners();
    saveToStorage();
  }

  void removeItem(NoteModel data, Function buildItem) {
    var index = listNotes.indexOf(data);
    var removeItem = listNotes.removeAt(index);
    noteListKey.currentState.removeItem(index, (context, animaniton) {
      return buildItem(context, removeItem, animaniton); 
    });
    notifyListeners();
    saveToStorage();
  }

  void saveToStorage() {
    List<String> noteListString = [];
    for (var item in listNotes) {
      noteListString.add(jsonEncode(item.toJson()));
    }
    print(noteListString.length);
    storageService.setItem(key, noteListString);
  }
}
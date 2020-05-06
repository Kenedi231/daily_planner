import 'dart:convert';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/locator.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:app_list/core/services/localization/app_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class NotesViewModel extends BaseViewModel {
  NotesViewModel();

  String key = 'notes_list';

  bool deleteMode = false;
  List<NoteModel> listNotes = List<NoteModel>();
  List<int> listForDelete = List<int>();
  GlobalKey<AnimatedListState> noteListKey = GlobalKey<AnimatedListState>();

  void init() {
    listNotes.clear();
    List<dynamic> todoListString = storageService.getItem(key);
    if (todoListString == null) return;
    for (var item in todoListString) {
      listNotes.add(NoteModel.fromJson(jsonDecode(item)));
    }
    sortNotes();
    notifyListeners();
  }

  void disableDeleteMode() {
    listForDelete.clear();
    deleteMode = false;
    notifyListeners();
  }

  void runMultipleDelete(Function buildItem) {
    for (int index in listForDelete) {
      removeItem(listNotes[index], buildItem);
    }
    disableDeleteMode();
  }

  void multipleDelete(NoteModel item) {
    listForDelete.clear();
    var index = listNotes.indexOf(item);
    listForDelete.add(index);
    deleteMode = true;
    notifyListeners();
  }

  String dateFormating(String str) {
    var localeController = locator<AppLanguage>();
    String currentLocal = localeController.currentLocale.languageCode;
    var date = DateTime.parse(str);
    var dateFormat = new DateFormat('dd MMMM yyyy', currentLocal);
    return dateFormat.format(date);
  }
  
  void createNewNotes() async {
    NoteModel item = await navigation.navigateToNotesItem(null);
    if (item == null) return;
    listNotes.add(item);
    noteListKey.currentState.insertItem(listNotes.length - 1, duration: Duration(microseconds: 0));
    sortNotes();
    notifyListeners();
    saveToStorage();
  }

  void editItem(NoteModel data) async {
    var index = listNotes.indexOf(data);
    if (deleteMode) {
      if (listForDelete.contains(index)) {
        listForDelete.remove(index);
      } else {
        listForDelete.add(index);
      }
    } else {
      NoteModel item = await navigation.navigateToNotesItem(listNotes[index]);
      if (item == null) return;
      listNotes[index] = item;
      saveToStorage();
    }
    notifyListeners();
  }

  void removeItem(NoteModel data, Function buildItem) {
    var index = listNotes.indexOf(data);
    var removeItem = listNotes.removeAt(index);
    noteListKey.currentState.removeItem(index, (context, animaniton) {
      return buildItem(context, removeItem, animaniton, false); 
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

  void sortNotes() {
    listNotes.sort((item1, item2) {
      DateTime date1 = DateTime.parse(item1.date);
      DateTime date2 = DateTime.parse(item2.date);
      return date2.compareTo(date1);
    });
  }
}
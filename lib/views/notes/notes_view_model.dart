import 'dart:convert';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/locator.dart';
import 'package:app_list/core/models/CategoryModel.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:app_list/core/services/localization/app_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesViewModel extends BaseViewModel {
  NotesViewModel();

  List<CategoryModel> categories = List<CategoryModel>();

  String key = 'notes_list';
  String categoryKey = 'category_list';

  bool deleteMode = false;
  CategoryModel currentCategory;
  List<NoteModel> allNotes;
  List<NoteModel> listNotes = List<NoteModel>();
  List<int> listForDelete = List<int>();
  GlobalKey<AnimatedListState> noteListKey = GlobalKey<AnimatedListState>();

  void init() {
    // storageService.removeItem(categoryKey);
    updateCategory();
    listNotes.clear();
    List<dynamic> todoListString = storageService.getItem(key);
    if (todoListString == null) return;
    for (var item in todoListString) {
      listNotes.add(NoteModel.fromJson(jsonDecode(item)));
    }
    sortNotes();
    allNotes = [...listNotes];
    notifyListeners();
  }

  void setCategory(CategoryModel value, Function buildItem) {
    currentCategory = value;
    filterByCategory(buildItem);
    sortNotes();
    notifyListeners();
  }

  void updateCategory() {
    categories.clear();
    List<dynamic> categoryListString = storageService.getItem(categoryKey);
    if (categoryListString != null) {
      for (var item in categoryListString) {
        categories.add(CategoryModel.fromJson(jsonDecode(item)));
      }
    }
    // initial key value
    categories.insert(0, CategoryModel(
      icon: Icons.bookmark_border,
      name: 'All notes',
      color: Colors.blueAccent,
    ));
    categories.add(CategoryModel(
      color: Colors.white,
      name: 'New',
      icon: Icons.add,
    ));
    currentCategory = currentCategory ?? categories[0];
    notifyListeners();
  }

  void filterByCategory(Function buildItem) {
    if (currentCategory.name == 'All notes') {
      for (var item in allNotes) {
        if (!listNotes.contains(item)) {
          listNotes.add(item);
          noteListKey.currentState.insertItem(listNotes.length - 1, duration: Duration(microseconds: 200));
        }
      }
    } else {
      for (var item in allNotes) {
        if (!listNotes.contains(item) && item.category?.name == currentCategory.name) {
          listNotes.add(item);
          noteListKey.currentState.insertItem(listNotes.length - 1, duration: Duration(microseconds: 0));
        } else if (listNotes.contains(item) && item.category?.name != currentCategory.name) {
          var index = listNotes.indexOf(item);
          var removeItem = listNotes.removeAt(index);
          noteListKey.currentState.removeItem(index, (context, animaniton) {
            return buildItem(context, removeItem, animaniton, false); 
          });
        }
      }
    }
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
    if (deleteMode) return;
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
    var now = DateTime.now();
    bool checkYear = date.year == now.year;
    String format = checkYear ? 'dd MMMM' : 'dd MMMM yyyy';
    var dateFormat = new DateFormat(format, currentLocal);
    return dateFormat.format(date);
  }
  
  void createNewNotes() async {
    NoteModel item = await navigation.navigateToNotesItem(null);
    updateCategory();
    if (item == null) return;
    listNotes.add(item);
    noteListKey.currentState.insertItem(listNotes.length - 1, duration: Duration(microseconds: 0));
    allNotes = [...listNotes];
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
      updateCategory();
      if (item == null) return;
      var indexFromAll = allNotes.indexOf(listNotes[index]);
      allNotes[indexFromAll] = item;
      listNotes[index] = item;
      saveToStorage();
      sortNotes();
    }
    notifyListeners();
  }

  void removeItem(NoteModel data, Function buildItem) {
    var index = listNotes.indexOf(data);
    var indexFromAll = allNotes.indexOf(data);
    allNotes.removeAt(indexFromAll);
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
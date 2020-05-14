import 'dart:convert';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/locator.dart';
import 'package:app_list/core/models/CategoryModel.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:app_list/core/services/localization/app_language.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

class NotesItemViewModel extends BaseViewModel {
  String heroTag = 'note-${randomString(20)}';
  String dateNow = DateTime.now().toString();
  String categoryKey = 'category_list';
  NoteModel currentItem;

  List<CategoryModel> categories = List<CategoryModel>();

  CategoryModel currentValue;

  set setCurrentValue(CategoryModel value) {
    currentValue = value;
    notifyListeners();
  }

  void init(NoteModel item) {
    currentItem = item;
    updateCategory();
    if (item == null) return;
    noteController.text = item.text;
    heroTag = item.heroTag;
    dateNow = item.date;
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
    categories.add(CategoryModel(
      icon: Icons.bookmark_border,
      name: 'No category',
      color: Colors.blueAccent,
    ));
    categories.add(CategoryModel(
      color: Colors.white,
      name: 'New',
      icon: Icons.add,
    ));

    int index = categories.indexWhere((element) => element.name == currentItem?.category?.name);
    currentValue = index != -1 ? categories[index] : categories[categories.length - 2];
    notifyListeners();
  }


  NotesItemViewModel();
  
  FocusNode focusNode = FocusNode();
  TextEditingController noteController = TextEditingController();

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

  void saveNote() {
    String title = noteController.text;
    if (title.length > 70) {
      title = title.substring(0, 70);
    }
    bool saveCategory = currentValue.name == 'No category';
    NoteModel newNote = NoteModel(title, DateTime.now().toString(), noteController.text, saveCategory ? null : currentValue, heroTag);
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
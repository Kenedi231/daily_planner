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


  // TODO: save to storage and remove it
  List<CategoryModel> categories = [
    CategoryModel(
      icon: Icons.bookmark,
      name: 'Work',
      color: Colors.red,
    ),
    CategoryModel(
      icon: Icons.bookmark,
      name: 'Life',
      color: Colors.blue,
    ),
    CategoryModel(
      icon: Icons.bookmark,
      name: 'Personal',
      color: Colors.purple,
    ),
    CategoryModel(
      icon: Icons.bookmark_border,
      name: 'No category',
      color: Colors.blueAccent,
    ),
  ];

  CategoryModel currentValue;

  set setCurrentValue(CategoryModel value) {
    currentValue = value;
    notifyListeners();
  }

  void init(NoteModel item) {
    int index = categories.indexWhere((element) => element.name == item?.category?.name);
    currentValue = index != -1 ? categories[index] : categories[categories.length - 1];
    if (item == null) return;
    noteController.text = item.text;
    heroTag = item.heroTag;
    dateNow = item.date;
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

  List<int> searchCategory (String keyword, items) {
    List<int> result = List<int>();
    if (keyword != null && items != null) {
      keyword.split(" ").forEach((k) {
        int i = 0;
        items.forEach((item) {
          if (keyword.isEmpty || (k.isNotEmpty &&
              (item.value.name.toString().toLowerCase().contains(k.toLowerCase())))) {
            result.add(i);
          }
          i++;
        });
      });
    }

    if(keyword.isEmpty){
      result = Iterable<int>.generate(items.length).toList();
    }
    return (result);
  }

  @override
  void dispose() {
    focusNode.dispose();
    noteController.dispose();
    super.dispose();
  }
}
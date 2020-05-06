import 'dart:convert';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/models/TodoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TodoViewModel extends BaseViewModel {
  final key = 'todo_list';

  TodoViewModel();
  List<TodoItemModel> todoList = [];
  GlobalKey<AnimatedListState> todoListKey = GlobalKey<AnimatedListState>();
  ScrollController todoListController = new ScrollController();
  bool floatingActionButtonVisible = true;

  void initViewModel() {
    todoList.clear();
    List<dynamic> todoListString = storageService.getItem(key);
    if (todoListString == null) return;
    for (var item in todoListString) {
      todoList.add(TodoItemModel.fromJson(jsonDecode(item)));
    }
    todoListController.addListener(() {
      if (todoListController.position.userScrollDirection == ScrollDirection.reverse) {
        if (!floatingActionButtonVisible) return;
        floatingActionButtonVisible = false;
        notifyListeners();
      } else {
        if (floatingActionButtonVisible) return;
        floatingActionButtonVisible = true;
        notifyListeners();
      }
    });
    notifyListeners();
  }
  

  void createNewTodo() async {
    TodoItemModel item = await navigation.navigateToTODOItem(null);
    if  (item == null) return;
    todoList.insert(0, item);
    todoListKey.currentState.insertItem(0, duration: Duration(microseconds: 0));
    notifyListeners();
    saveToStorage();
  }

  void editItem(TodoItemModel data) async {
    var index = todoList.indexOf(data);
    TodoItemModel item = await navigation.navigateToTODOItem(todoList[index]);
    if (item == null) return;
    todoList[index] = item;
    notifyListeners();
    saveToStorage();
  }

  void removeItem(TodoItemModel data, Function buildItem) {
    var index = todoList.indexOf(data);
    var removeItem = todoList.removeAt(index);
    todoListKey.currentState.removeItem(index, (context, animaniton) {
      return buildItem(context, removeItem, animaniton); 
    });
    notifyListeners();
    saveToStorage();
  }
  
  void switchStatus(TodoItemModel data) {
    var index = todoList.indexOf(data);
    todoList[index] = new TodoItemModel(
      todoList[index].title,
      todoList[index].date,
      !todoList[index].completed,
      todoList[index].heroTag,
    );
    notifyListeners();
    saveToStorage();
  }

  void saveToStorage() {
    List<String> todoListString = [];
    for (var item in todoList) {
      
      todoListString.add(jsonEncode(item.toJson()));
    }
    print(todoListString.length);
    storageService.setItem(key, todoListString);
  }

  @override
  void dispose() {
    todoListController.dispose();
    super.dispose();
  }
}
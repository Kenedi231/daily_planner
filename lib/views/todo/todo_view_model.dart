import 'dart:convert';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/models/TodoModel.dart';

class TodoViewModel extends BaseViewModel {
  final key = 'todo_list';

  TodoViewModel();
  List<TodoItemModel> todoList = [];

  void initViewModel() {
    todoList.clear();
    List<dynamic> todoListString = storageService.getItem(key);
    if (todoListString == null) return;
    for (var item in todoListString) {
      print(item);
      todoList.add(TodoItemModel.fromJson(jsonDecode(item)));
    }
    notifyListeners();
  }
  

  void createNewTodo() async {
    TodoItemModel item = await navigation.navigateToTODOItem(null);
    if  (item == null) return;
    todoList.add(item);
    notifyListeners();
    saveToStorage();
  }

  void editItem(int index) async {
    TodoItemModel item = await navigation.navigateToTODOItem(todoList[index]);
    if (item == null) return;
    todoList[index] = item;
    notifyListeners();
    saveToStorage();
  }

  void removeItem(int index) {
    todoList.removeAt(index);
    notifyListeners();
    saveToStorage();
  }
  
  void switchStatus(int index) {
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
}
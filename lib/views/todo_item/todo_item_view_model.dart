import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/models/TodoModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:random_string/random_string.dart';

class TodoItemViewModel extends BaseViewModel {
  String heroTag = 'todo-${randomString(20)}';

  TodoItemViewModel();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController todoController = TextEditingController();

  void init(TodoItemModel item) {
    if (item == null) return;
    todoController.text = item.title;
    heroTag = item.heroTag;
  }
  

  void toBack() {
    TodoItemModel todo = new TodoItemModel(todoController.text, DateTime.now().toString(), false, heroTag);
    navigation.pop(todo);
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }
  // Add ViewModel specific code here
}
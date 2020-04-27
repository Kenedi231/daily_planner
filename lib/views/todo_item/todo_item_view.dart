library todo_item_view;

import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/navigator_service.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'todo_item_view_model.dart';

part 'todo_item.dart';

class TodoItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoItemViewModel viewModel = TodoItemViewModel();
    return ViewModelProvider<TodoItemViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _TodoItem(viewModel);
      }
    );
  }
}
library todo_item_view;

import 'package:app_list/core/models/TodoModel.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'todo_item_view_model.dart';

part 'todo_item.dart';

class TodoItemView extends StatelessWidget {
  final TodoItemModel item;

  TodoItemView({this.item});

  @override
  Widget build(BuildContext context) {
    TodoItemViewModel viewModel = TodoItemViewModel();
     var heroTag = item == null ? null : item.heroTag;
    return ViewModelProvider<TodoItemViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.init(item);
      },
      builder: (context, viewModel, child) {
        return _TodoItem(viewModel, heroTag);
      }
    );
  }
}
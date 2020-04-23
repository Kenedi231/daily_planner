library todo_view;

import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'todo_view_model.dart';

part 'todo.dart';

class TodoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TodoViewModel viewModel = TodoViewModel();
    return ViewModelProvider<TodoViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _Todo(viewModel);
      }
    );
  }
}
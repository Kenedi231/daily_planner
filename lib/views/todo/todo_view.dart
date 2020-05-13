library todo_view;

import 'package:app_list/core/models/TodoModel.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'todo_view_model.dart';

part 'todo.dart';

class TodoView extends StatefulWidget {
  @override
  _TodoViewState createState() => _TodoViewState();
}

class _TodoViewState extends State<TodoView> with AutomaticKeepAliveClientMixin<TodoView> {
  

  @override
  Widget build(BuildContext context) {
    super.build(context);
    TodoViewModel viewModel = TodoViewModel();
    return ViewModelProvider<TodoViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.initViewModel();
      },
      builder: (context, viewModel, child) {
        return _Todo(viewModel);
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}
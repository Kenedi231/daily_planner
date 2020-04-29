library notes_item_view;

import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'notes_item_view_model.dart';

part 'notes_item.dart';

class NotesItemView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotesItemViewModel viewModel = NotesItemViewModel();
    return ViewModelProvider<NotesItemViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _NotesItem(viewModel);
      }
    );
  }
}
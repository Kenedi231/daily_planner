library notes_view;

import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'notes_view_model.dart';

part 'notes.dart';

class NotesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NotesViewModel viewModel = NotesViewModel();
    return ViewModelProvider<NotesViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _Notes(viewModel);
      }
    );
  }
}
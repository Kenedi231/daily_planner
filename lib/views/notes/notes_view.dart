library notes_view;

import 'package:app_list/core/models/CategoryModel.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/widgets/dropdown_dialog/dropdown_dialog_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'notes_view_model.dart';

part 'notes.dart';

class NotesView extends StatefulWidget {
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> with AutomaticKeepAliveClientMixin<NotesView> {
  @override
  Widget build(BuildContext context) {
    NotesViewModel viewModel = NotesViewModel();
    return ViewModelProvider<NotesViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.init();
      },
      builder: (context, viewModel, child) {
        return _Notes(viewModel);
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
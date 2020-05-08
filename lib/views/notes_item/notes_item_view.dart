library notes_item_view;

import 'package:app_list/core/models/CategoryModel.dart';
import 'package:app_list/core/models/NoteModel.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/widgets/dropdown_dialog/dropdown_dialog_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'notes_item_view_model.dart';

part 'notes_item.dart';

class NotesItemView extends StatelessWidget {
  final NoteModel item;

  NotesItemView({this.item});

  @override
  Widget build(BuildContext context) {
    NotesItemViewModel viewModel = NotesItemViewModel();
    var heroTag = item == null ? null : item.heroTag;
    return ViewModelProvider<NotesItemViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.init(item);
      },
      builder: (context, viewModel, child) {
        return _NotesItem(viewModel, heroTag);
      }
    );
  }
}
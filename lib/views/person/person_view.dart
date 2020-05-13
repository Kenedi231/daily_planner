library person_view;

import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/utils/model_bottom_sheet.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'person_view_model.dart';

part 'person.dart';

class PersonView extends StatefulWidget {
  @override
  _PersonViewState createState() => _PersonViewState();
}

class _PersonViewState extends State<PersonView> with AutomaticKeepAliveClientMixin<PersonView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    PersonViewModel viewModel = PersonViewModel();
    return ViewModelProvider<PersonViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.initPage();
      },
      builder: (context, viewModel, child) {
        return _Person(viewModel);
      }
    );
  }
}
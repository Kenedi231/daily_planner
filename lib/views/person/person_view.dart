library person_view;

import 'package:app_list/widgets/img_crop/img_crop_widget.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'person_view_model.dart';

part 'person.dart';

class PersonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersonViewModel viewModel = PersonViewModel();
    return ViewModelProvider<PersonViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        // Do something once your viewModel is initialized
      },
      builder: (context, viewModel, child) {
        return _Person(viewModel);
      }
    );
  }
}
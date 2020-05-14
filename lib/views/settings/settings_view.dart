library settings_view;

import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'settings_view_model.dart';

part 'settings.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingsViewModel viewModel = SettingsViewModel();
    return ViewModelProvider<SettingsViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.init();
      },
      builder: (context, viewModel, child) {
        return _Settings(viewModel);
      }
    );
  }
}
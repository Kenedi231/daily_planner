library home_view;

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:flutter/material.dart';
import 'home_view_model.dart';

part 'home.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with AutomaticKeepAliveClientMixin<HomeView> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = HomeViewModel();
    return ViewModelProvider<HomeViewModel>.withConsumer(
      viewModel: viewModel,
      onModelReady: (viewModel) {
        viewModel.initPageController();
      },
      builder: (context, viewModel, child) {
        return _Home(viewModel);
      }
    );
  }
}
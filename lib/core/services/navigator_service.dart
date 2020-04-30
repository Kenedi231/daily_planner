import 'package:app_list/core/models/NoteModel.dart';
import 'package:app_list/core/models/TodoModel.dart';
import 'package:app_list/views/notes_item/notes_item_view.dart';
import 'package:app_list/views/todo_item/todo_item_view.dart';
import 'package:app_list/widgets/img_crop/img_crop_widget.dart';

import '../../core/base/base_service.dart';
import 'package:flutter/material.dart';

class NavigatorService extends BaseService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T> navigateToPage<T>(MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPage: pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPage: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.push(pageRoute);
  }

  Future<T> navigateToPageWithReplacement<T>(
      MaterialPageRoute<T> pageRoute) async {
    log.i('navigateToPageWithReplacement: '
      'pageRoute: ${pageRoute.settings.name}');
    if (navigatorKey.currentState == null) {
      log.e('navigateToPageWithReplacement: Navigator State is null');
      return null;
    }
    return navigatorKey.currentState.pushReplacement(pageRoute);
  }

  void pop<T>([T result]) {
    log.i('goBack:');
    if (navigatorKey.currentState == null) {
      log.e('goBack: Navigator State is null');
      return;
    }
    navigatorKey.currentState.pop(result);
  }

  Future<T> navigateToCropImage<T>(image) async {
    return await navigateToPage(MaterialPageRoute(builder: (context) => ImgCropWidget(image: image)));
  }

  Future<T> navigateToTODOItem<T>(TodoItemModel item) async {
    return await navigateToPage(MaterialPageRoute(builder: (context) => TodoItemView(item: item)));
  }

  Future<T> navigateToNotesItem<T>(NoteModel item) async {
    return await navigateToPage(MaterialPageRoute(builder: (context) => NotesItemView(item: item)));
  }

  
}
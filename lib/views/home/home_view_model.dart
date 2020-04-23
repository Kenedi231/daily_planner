import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/views/notes/notes_view.dart';
import 'package:app_list/views/person/person_view.dart';
import 'package:app_list/views/todo/todo_view.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends BaseViewModel {
  int _currentPage = 0;
  PageController pageController;

  List<Widget> pageList = [
    new NotesView(),
    new TodoView(),
    new PersonView(),
  ];

  HomeViewModel({int currentPage = 0}) : this._currentPage = currentPage;

  void initPageController() {
    pageController = new PageController();
  }

  int get currentPage => this._currentPage;
  set currentPage(int value) {
    this._currentPage = value;
    pageController.animateToPage(
      value,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
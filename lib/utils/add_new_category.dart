import 'dart:convert';

import 'package:app_list/core/locator.dart';
import 'package:app_list/core/models/CategoryModel.dart';
import 'package:app_list/core/services/local_storage_service.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/core/services/navigator_service.dart';
import 'package:app_list/utils/model_bottom_sheet.dart';
import 'package:flutter/material.dart';

Future<void> showNewCategorySheet(context) async {
  var i18n = AppLocalizations.of(context).translate;
  String categoryKey = 'category_list';

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController newCategoryController = TextEditingController();
  List<CategoryModel> categories = List<CategoryModel>();

  List<Color> avaibleColors = [Colors.red, Colors.purple, Colors.green, Colors.amber, Colors.blue];
  Color _selectedValue = avaibleColors[0];

  
  List<dynamic> categoryListString = locator<LocalStorageService>().getItem(categoryKey);
  if (categoryListString != null) {
    for (var item in categoryListString) {
      categories.add(CategoryModel.fromJson(jsonDecode(item)));
    }
  }

  void saveCategories() {
    CategoryModel newItem = CategoryModel(
      icon: Icons.bookmark,
      name: newCategoryController.text,
      color: _selectedValue,
    );
    categories.add(newItem);
    categoryListString = List<String>();
    for (var item in categories) {
      categoryListString.add(jsonEncode(item.toJson()));
    }
    locator<LocalStorageService>().setItem(categoryKey, categoryListString);
    locator<NavigatorService>().pop();
  }

  await showActionSheet(context, StatefulBuilder(
    builder: (context, setState) => Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            i18n('New note category'),
            style: TextStyle(
              color: Theme.of(context).textTheme.headline5.color,
            ),
          ),
          Form(
            key: formKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                PopupMenuButton(
                  icon: Icon(Icons.bookmark, color: _selectedValue, size: 34),
                  itemBuilder: (context) {
                    return [
                      new PopupMenuWidget(
                        child: Wrap(
                          children: avaibleColors.map((e) => Container(
                            margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedValue = e;
                                  });
                                  locator<NavigatorService>().pop();
                                },
                                child: Container(
                                  height: 75,
                                  width: 75,
                                  color: e,
                                ),
                              ),
                            ),
                          )).toList(),
                        ),
                      ),
                    ];
                    // avaibleColors.map((e) => PopupMenuItem<Color>(
                    //   value: e,
                    //   child: Container(
                    //     margin: EdgeInsets.fromLTRB(10, 5, 0, 5),
                    //     child: ClipRRect(
                    //       borderRadius: BorderRadius.all(Radius.circular(15)),
                    //       child: Container(
                    //         height: 75,
                    //         width: 75,
                    //         color: e,
                    //       ),
                    //     ),
                    //   ),
                    // )).toList();
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: TextFormField(
                      controller: newCategoryController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        hintText: i18n('Name'),
                        hintStyle: TextStyle(
                          fontSize: 16,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).buttonColor,
                          ),
                        ),
                      ),
                      validator: (String value) {
                        if (categories.where((element) => element.name == value).length != 0) {
                          return i18n('Same name already exist');
                        }
                        if (value == 'All notes' || value == 'No category' || value == 'New') {
                          return i18n('This name is not avaible');
                        }
                        return null;
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            buttonMinWidth: 170,
            alignment: MainAxisAlignment.center,
            buttonTextTheme: ButtonTextTheme.primary,
            buttonPadding: EdgeInsets.all(0),
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                onPressed: () {
                  locator<NavigatorService>().pop();
                },
                child: Container(
                  constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text(
                    i18n('CANCEL'),
                    style: TextStyle(color: Theme.of(context).textTheme.headline5.color, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                onPressed: () {
                  if (formKey.currentState.validate()) {
                    saveCategories();
                  }
                },
                child: Container(
                  constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text(
                    i18n('OK'),
                    style: TextStyle(color: Theme.of(context).textTheme.headline5.color, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        ]
      ),
    ),
  ));
}

class PopupMenuWidget<T> extends PopupMenuEntry<T> {
  const PopupMenuWidget({ Key key, this.height, this.child }) : super(key: key);

  @override
  final Widget child;

  @override
  final double height;

  @override
  bool get enabled => false;

  @override
  _PopupMenuWidgetState createState() => new _PopupMenuWidgetState();

  @override
  bool represents(T value) {
    return true;
    throw UnimplementedError();
  }
}

class _PopupMenuWidgetState extends State<PopupMenuWidget> {
  @override
  Widget build(BuildContext context) => widget.child;
}
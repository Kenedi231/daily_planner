import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/core/services/navigator_service.dart';
import 'package:app_list/utils/model_bottom_sheet.dart';
import 'package:flutter/material.dart';

void showNewCategorySheet(context) {
    var i18n = AppLocalizations.of(context).translate;

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController newCategoryController = TextEditingController();

    showActionSheet(context, Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(i18n('New note category')),
          Form(
            key: formKey,
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.bookmark, color: Colors.red, size: 34),
                  onPressed: null,
                ),
                Expanded(
                  child: TextFormField(
                    controller: newCategoryController,
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
                      if (value.isEmpty) {
                        return i18n('Please, enter some text');
                      }
                      return null;
                    }
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            buttonMinWidth: 150,
            alignment: MainAxisAlignment.center,
            buttonTextTheme: ButtonTextTheme.primary,
            buttonPadding: EdgeInsets.all(0),
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  locator<NavigatorService>().pop();
                },
                child: Container(
                  constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text(
                    i18n('CANCEL'),
                    style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  locator<NavigatorService>().pop();
                },
                child: Container(
                  constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text(
                    i18n('OK'),
                    style: TextStyle(color: Theme.of(context).textTheme.headline6.color, fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          )
        ]
      ),
    ));
  }
library dropdown_dialog_widget;

import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/core/services/navigator_service.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

part 'dropdown_dialog.dart';

class DropdownDialogWidget extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic selectedValue;
  final Function onChanged;
  final Function search;

  const DropdownDialogWidget({Key key, this.items, this.selectedValue, this.onChanged, this.search}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return _DropdownDialog(items: items, selectedValue: selectedValue, onChanged: onChanged, search: search);
  }
}
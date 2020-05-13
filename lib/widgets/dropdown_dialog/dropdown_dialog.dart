part of dropdown_dialog_widget;

class _DropdownDialog extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic selectedValue;
  final Function onChanged;

  const _DropdownDialog({Key key, this.items, this.selectedValue, this.onChanged}) : super(key: key);

  List<int> searchCategory (String keyword, items) {
    List<int> result = List<int>();
    if (keyword != null && items != null) {
      keyword.split(' ').forEach((k) {
        int i = 0;
        items.forEach((item) {
          if (keyword.isEmpty || (k.isNotEmpty &&
              (item.value.name.toString().toLowerCase().contains(k.toLowerCase())))) {
            result.add(i);
          }
          i++;
        });
      });
    }

    if(keyword.isEmpty){
      result = Iterable<int>.generate(items.length).toList();
    }
    return (result);
  }

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return SearchableDropdown(
      icon: Icon(Icons.arrow_drop_down),
      iconEnabledColor: Theme.of(context).primaryColor,
      searchHint: i18n('Select category'),
      closeButton: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              onPressed: () {
                locator<NavigatorService>().pop();
              },
              child: Container(
                constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width / 2),
                child: Text(
                  i18n('Cancel'),
                  style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
      menuBackgroundColor: Theme.of(context).primaryColor,
      underline: Container(height: 0),
      items: items,
      value: selectedValue,
      selectedValueWidgetFn: (value) {
        return Text(value.name);
      },
      onChanged: onChanged,
      searchFn: searchCategory,
    );
  }
}
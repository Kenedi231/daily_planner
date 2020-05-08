part of dropdown_dialog_widget;

class _DropdownDialog extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>> items;
  final dynamic selectedValue;
  final Function onChanged;
  final Function search;

  const _DropdownDialog({Key key, this.items, this.selectedValue, this.onChanged, this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    print(selectedValue);
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
        print(value);
        return Text(value.name);
      },
      onChanged: onChanged,
      searchFn: search,
    );
  }
}
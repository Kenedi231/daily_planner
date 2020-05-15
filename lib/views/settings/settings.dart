part of settings_view;

class _Settings extends StatelessWidget {
  final SettingsViewModel viewModel;

  _Settings(this.viewModel);

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n('Settings')),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Text(
              i18n('Profile'),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline5.color,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: TextField(
              controller: viewModel.controller,
              focusNode: viewModel.focusNodeName,
              
              maxLength: 30,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.done),
                  onPressed: viewModel.saveName,
                ),
                hintText: i18n('Name'),
                errorText: viewModel.wrongName ? i18n('Enter some text') : null,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              i18n('Interface'),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline5.color,
                fontSize: 18,
              ),
            ),
          ),
          Container(color: Colors.grey, height: 1),
          SwitchListTile(
            activeColor: Theme.of(context).iconTheme.color,
            activeTrackColor: Colors.lightBlueAccent,
            value: viewModel.darkMode,
            onChanged: (_) {
              viewModel.changeTheme();
            },
            title: Text(
              i18n('Dark mode'),
              style: TextStyle(
                color: Theme.of(context).textTheme.headline5.color,
              ),
            ),
          ),
          Container(color: Colors.grey, height: 1),
          PopupMenuButton(
            color: Theme.of(context).primaryColor,
            offset: Offset.fromDirection(1000),
            onSelected: viewModel.changeLocale,
            child: ListTile(
              title: Text(
                i18n('Language'),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline5.color,
                ),
              ),
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: <Widget>[
                  Text(
                    viewModel.currentLocal,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline5.color,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.keyboard_arrow_right),
                ],
              ),
            ),
            itemBuilder: (context) => viewModel.locales.map((e) {
              return PopupMenuItem(
                child: Text(
                  e,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
                value: e,
              );
            }).toList(),
          ),
          Container(color: Colors.grey, height: 1),
        ],
      ),
    );
  }
}
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
          Text(
            'Language',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline5.color,
            ),
          ),
        ],
      ),
    );
  }
}
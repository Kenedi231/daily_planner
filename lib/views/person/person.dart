part of person_view;

class _Person extends StatelessWidget {
  final PersonViewModel viewModel;

  _Person(this.viewModel);

  void _showPhotoActionSheet(context) {
    var i18n = AppLocalizations.of(context).translate;
    showActionSheet(context, Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        new ListTile(
          leading: Icon(Icons.photo_camera),
          title: Text(i18n('Camera')),
          onTap: () async {
            await viewModel.getImage(context, 'camera');
          },
        ),
        new ListTile(
          leading: Icon(Icons.photo_library),
          title: Text(i18n('Gallery')),
          onTap: () async {
            await viewModel.getImage(context, 'gallery');
          },
        ),
        new ListTile(
          leading: Icon(Icons.close),
          title: Text(i18n('Cancel')),
          onTap: viewModel.closeAction,
        ),
      ]
    ));
  }

  void _showLanguageActionSheet(context) {
    var locales = AppLocalizations.locales;
    var i18n = AppLocalizations.of(context).translate;
    List<Widget> children = List<Widget>();
    locales.forEach((item) {
      children.add(new ListTile(
        title: Text(item),
        onTap: () {
          viewModel.changeLocale(item);
          viewModel.closeAction();
        }
      ));
    });
    children.add(new ListTile(
      title: Text(i18n('Cancel')),
      onTap: viewModel.closeAction,
    ));
    showActionSheet(context, Column(
      mainAxisSize: MainAxisSize.min,
      children: children,
    ));
  }


  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Container(
      margin: EdgeInsets.all(0),
      color: Theme.of(context).backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPhotoActionSheet(context);
              },
              child: CircleAvatar(
                backgroundImage: viewModel.image == null 
                  ? null 
                  : FileImage(viewModel.image),
                radius: 70,
                backgroundColor: Theme.of(context).accentColor,
                child: viewModel.image == null 
                  ? Icon(Icons.add_a_photo, size: 50, color: Theme.of(context).iconTheme.color)
                  : null,
              ),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Claire Rain',
            style: TextStyle(
              color: Theme.of(context).textTheme.headline5.color,
              fontSize: 30,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: viewModel.navigateToSettings,
            child: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
          ),
          SizedBox(height: 20),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: () {
              _showLanguageActionSheet(context);
            },
            child: Text(
              i18n('Change language'),
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
part of person_view;

class _Person extends StatelessWidget {
  final PersonViewModel viewModel;

  _Person(this.viewModel);

  void _showPhotoActionSheet(context) {
    var i18n = AppLocalizations.of(context).translate;
    showActionSheet(context, Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlatButton(
            onPressed: () async {
              await viewModel.getImage(context, 'camera');
            },
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(width: 2, color: Colors.black38)),
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.black38,
                    size: 34,
                  ),
                ),
                Text(
                  i18n('Camera'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline5.color,
                  ),
                ),
              ],
            )
          ),
          FlatButton(
            onPressed: () async {
              await viewModel.getImage(context, 'gallery');
            },
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      border: Border.all(width: 2, color: Colors.black38)),
                  child: Icon(
                    Icons.photo_library,
                    color: Colors.black38,
                    size: 34,
                  ),
                ),
                Text(
                  i18n('Gallery'),
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline5.color,
                  ),
                ),
              ],
            )
          ),
        ]
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // var i18n = AppLocalizations.of(context).translate;
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
            viewModel.name,
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
        ],
      ),
    );
  }
}
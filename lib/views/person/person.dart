part of person_view;

class _Person extends StatelessWidget {
  final PersonViewModel viewModel;

  _Person(this.viewModel);

  void _showActionSheet(context) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          color: Theme.of(context).backgroundColor,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () async {
                    await viewModel.getImage(context, 'camera');
                  },
                ),
                new ListTile(
                  leading: Icon(Icons.photo_album),
                  title: Text('Gallery'),
                  onTap: () async {
                    await viewModel.getImage(context, 'gallery');
                  },
                ),
              ],
            )
          ),
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
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
                _showActionSheet(context);
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
              fontSize: 30,
              letterSpacing: 2.0,
            ),
          ),
          SizedBox(height: 50),
          GestureDetector(
            onTap: viewModel.changeTheme,
            child: Icon(
              viewModel.isLightTheme
                ? Icons.brightness_7
                : Icons.brightness_2,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
          ),
        ],
      ),
    );
  }
}
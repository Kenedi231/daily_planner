part of person_view;

class _Person extends StatelessWidget {
  final PersonViewModel viewModel;

  _Person(this.viewModel);

  void _showActionSheet(context) {
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Camera'),
                onTap: () async {
                  await viewModel.getImage('camera');
                  Navigator.pop(context);
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ImgCropWidget(image: viewModel.image)));
                },
              ),
              new ListTile(
                leading: Icon(Icons.photo_album),
                title: Text('Gallery'),
                onTap: () async {
                  await viewModel.getImage('gallery');
                  Navigator.pop(context);
                },
              ),
            ],
          )
        );
      }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Person')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showActionSheet(context);
        },
        child: Icon(Icons.photo_camera),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
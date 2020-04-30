part of img_crop_widget;

class _ImgCrop extends StatelessWidget {
  final image;
  final cropKey = GlobalKey<ImgCropState>();

  _ImgCrop({this.image});

  @override
  Widget build(BuildContext context) {
    var i18n = AppLocalizations.of(context).translate;
    return Scaffold(
      appBar: AppBar(
        title: Text(i18n('Zoom and crop')),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: Colors.black,
        child: ImgCrop(
          key: cropKey,
          chipRadius: 150,
          chipShape: 'circle',
          image: FileImage(image),
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final crop = cropKey.currentState;
          final croppedFile = await crop.cropCompleted(image, pictureQuality: 600);
          locator<NavigatorService>().pop(croppedFile);
        },
        child: Text(i18n('Crop')),
      ),
    );
  }
}
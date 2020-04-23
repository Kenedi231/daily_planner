part of img_crop_widget;

class _ImgCrop extends StatelessWidget {
  final image;
  final cropKey = GlobalKey<ImgCropState>();

  _ImgCrop({this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zoom and crop'),
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
    );
  }
}
library img_crop_widget;

import 'package:flutter/material.dart';
import 'package:simple_image_crop/simple_image_crop.dart';

part 'img_crop.dart';

class ImgCropWidget extends StatelessWidget {
  final image;

  ImgCropWidget({this.image});

  @override
  Widget build(BuildContext context) {
    return _ImgCrop(image: image);
  }
}
library img_crop_widget;

import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/localization/app_localization.dart';
import 'package:app_list/core/services/navigator_service.dart';
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
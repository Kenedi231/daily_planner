import 'dart:convert';
import 'dart:io';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/services/local_storage_service.dart';
import 'package:app_list/widgets/img_crop/img_crop_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PersonViewModel extends BaseViewModel {
  PersonViewModel();
  var image;

  void initPage() async {
    String base64String = LocalStorageService.getItem('avatar');
    var bytes = base64Decode(base64String);
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true).then((Directory directory) {
      image = new File('${directory.path}/avatar.png');
      image.writeAsBytesSync(bytes);
      notifyListeners();
    });
  }

  Future getImage(context, type) async {
    navigation.pop();
    image = await ImagePicker.pickImage(
      source: type == 'camera'
        ? ImageSource.camera
        : ImageSource.gallery,
    );
    if (image == null) return;
    image = await navigation.navigateToPage(MaterialPageRoute(builder: (context) => ImgCropWidget(image: image)));
    String base64String = base64Encode(image.readAsBytesSync());
    LocalStorageService.setItem('avatar', base64String);
    notifyListeners();
  }
  
  // Add ViewModel specific code here
}
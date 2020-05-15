import 'dart:convert';
import 'dart:io';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PersonViewModel extends BaseViewModel {
  static const AVATAR = 'avatar';
  static const NICKNAME = 'nickname';

  String name;

  PersonViewModel();
  var image;

  void initPage() async {
    name = storageService.getItem(NICKNAME) ?? 'Your Name';

    // init photo
    String base64String = storageService.getItem(AVATAR);
    if (base64String == null) return;
    var bytes = base64Decode(base64String);
    Directory appDocDirectory = await getApplicationDocumentsDirectory();

    new Directory(appDocDirectory.path+'/'+'dir').create(recursive: true).then((Directory directory) {
      image = new File('${directory.path}/avatar.png');
      image.writeAsBytesSync(bytes);
      notifyListeners();
    });
  }

  void navigateToSettings() async {
    await navigation.navigateToSettings();
    name = storageService.getItem(NICKNAME) ?? 'Your Name';
    notifyListeners();
  }

  Future getImage(context, type) async {
    navigation.pop();
    var tempImage;
    tempImage = await ImagePicker.pickImage(
      source: type == 'camera'
        ? ImageSource.camera
        : ImageSource.gallery,
    );
    if (tempImage == null) return;
    tempImage = await navigation.navigateToCropImage(tempImage);
    if (tempImage == null) return;
    image = tempImage;
    notifyListeners();
    storageService.setItem(AVATAR, 'null');
    String base64String = base64Encode(tempImage.readAsBytesSync());
    storageService.setItem(AVATAR, base64String);
  }  

  void closeAction() {
    navigation.pop();
  }
}
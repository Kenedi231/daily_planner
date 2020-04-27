import 'dart:convert';
import 'dart:io';

import 'package:app_list/core/base/base_view_model.dart';
import 'package:app_list/core/locator.dart';
import 'package:app_list/core/services/custom_theme_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class PersonViewModel extends BaseViewModel {
  PersonViewModel();
  var image;
  bool isLightTheme = false;

  void initPage() async {
    // init theme
    bool theme = storageService.getItem('light_theme');
    if (theme == null) {
      isLightTheme = true;
    } else {
      isLightTheme = theme;
    }

    // init photo
    String base64String = storageService.getItem('avatar');
    if (base64String == null) return;
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
    String base64String = base64Encode(tempImage.readAsBytesSync());
    storageService.setItem('avatar', base64String);
    notifyListeners();
  }

  void changeTheme() {
    var themeController = locator<CustomThemeService>();
    themeController.switchTheme();
    bool theme = themeController.islightTheme;
    isLightTheme = theme;
    storageService.setItem('light_theme', theme);
    notifyListeners();
  }
  
  // Add ViewModel specific code here
}
import 'package:app_list/core/base/base_view_model.dart';
import 'package:image_picker/image_picker.dart';

class PersonViewModel extends BaseViewModel {
  PersonViewModel();
  var image;

  Future getImage(type) async {
    image = await ImagePicker.pickImage(
      source: type == 'camera'
        ? ImageSource.camera
        : ImageSource.gallery,
    );
    if (image == null) return;
    notifyListeners();
  }
  
  // Add ViewModel specific code here
}
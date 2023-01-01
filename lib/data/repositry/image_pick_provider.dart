import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:we_coin/utils/color_manager.dart';

class ProfileImageController extends ChangeNotifier {
  final picker = ImagePicker();
  XFile? _image;
  XFile? get image => _image;

  Future pickGalleryImage(BuildContext context) async {
    final pickeFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if (pickeFile != null) {
      _image = XFile(pickeFile.path);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickeFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 100);
    notifyListeners();
    if (pickeFile != null) {
      _image = XFile(pickeFile.path);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 120,
              child: Column(
                children: [
                  ListTile(
                      leading: Icon(Icons.camera,
                          color: ColorsManager.APP_MAIN_COLOR),
                      title: Text("Camera"),
                      onTap: () {
                        pickCameraImage(context);
                        Navigator.pop(context);
                        notifyListeners();
                      }),
                  ListTile(
                      leading: Icon(Icons.image,
                          color: ColorsManager.APP_MAIN_COLOR),
                      title: Text("Gallery"),
                      onTap: () {
                        pickGalleryImage(context);
                        Navigator.pop(context);
                        notifyListeners();
                      })
                ],
              ),
            ),
          );
        });
  }
}

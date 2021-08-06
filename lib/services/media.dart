import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = new MediaService();
  static ImagePicker imagePicker = new ImagePicker();

  Future<dynamic> getImageFromLibrary() async {
    return await imagePicker.pickImage(source: ImageSource.gallery);
  }
}

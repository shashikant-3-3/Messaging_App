import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaService {
  static MediaService instance = new MediaService();
  ImagePicker imagePicker = new ImagePicker();

  Future<File> getImageFromLibrary() async {
    // ImagePicker imagePicker = ImagePicker();
    return await imagePicker.pickImage(source: ImageSource.gallery) as File;
  }
}

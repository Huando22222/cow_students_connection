import 'dart:io';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ImagePickerHelper {
  File? image;
  late BuildContext context; // Thêm trường context
  ImagePickerHelper(this.context); // Constructor nhận context.

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return null;

      final imageTemporary = File(pickedImage.path);
      // image = imageTemporary;
      context.read<AppRepo>().imageFile = imageTemporary;
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  // Thêm một getter để lấy ra giá trị của image
  // File? get getImage => image;
}

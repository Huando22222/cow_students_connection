import 'dart:io';
import 'package:cow_students_connection/providers/app_temp.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class ImagePickerHelper {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return null;

      image = File(pickedImage.path);
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  // Thêm một thuộc tính để trả về giá trị File?
  File? get getImageFile => image;
}

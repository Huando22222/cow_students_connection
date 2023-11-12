import 'dart:io';
import 'package:flutter/material.dart';

class AppTemp extends ChangeNotifier {
  /////////////////////////
  File? _imageFile;
  File? get imageFile {
    return _imageFile;
  }

  set imageFile(File? value) {
    _imageFile = value;
    notifyListeners(); // Thêm notifyListeners ở đây
  }
}

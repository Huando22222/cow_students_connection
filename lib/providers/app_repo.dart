import 'dart:io';
import 'package:cow_students_connection/data/models/account.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:flutter/material.dart';

class AppRepo extends ChangeNotifier {
  String? phone;
  String? password;
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;
  File? _imageFile;

  File? get imageFile {
    return _imageFile;
  }

  set imageFile(File? value) {
    _imageFile = value;
    notifyListeners(); // Thêm notifyListeners ở đây
  }

  account? Account;
  user? User;
}

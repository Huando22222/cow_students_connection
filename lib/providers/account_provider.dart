import 'package:cow_students_connection/data/models/account.dart';
import 'package:flutter/material.dart';

class AppRepo extends ChangeNotifier {
  String? _phone;
  String? _password;

  set setPhone(String? value) {
    notifyListeners(); // Thông báo rằng dữ liệu đã thay đổi
    _phone = value;
  }

  String? get getPhone {
    return _phone;
  }

  set setPassword(String? value) {
    notifyListeners(); // Thông báo rằng dữ liệu đã thay đổi
    _password = value;
  }

  String? get getPassword {
    return _password;
  }

  account? _account;
}

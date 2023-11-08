import 'package:cow_students_connection/data/models/account.dart';
import 'package:flutter/material.dart';

class AppRepo extends ChangeNotifier {
  String? _phone;
  String? _password;

  set setPhone(String? value) {
    _phone = value;
  }

  String? get getPhone {
    return _phone;
  }

  account? _account;
}

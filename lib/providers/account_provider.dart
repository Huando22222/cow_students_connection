import 'package:cow_students_connection/data/models/account.dart';
import 'package:flutter/material.dart';

class AppRepo extends ChangeNotifier {
  String? phone;
  String? password;
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;
  // AppRepoAccount(this._phone)

  account? Account;
}

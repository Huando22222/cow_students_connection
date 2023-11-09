import 'package:cow_students_connection/data/models/account.dart';
import 'package:flutter/material.dart';

class AppRepo extends ChangeNotifier {
  String? phone;
  String? password;
  String? gfullname;
  String? gemail;
  String? gid;
  String? gimage;

  // AppRepoAccount(this._phone)

  account? Account;
}

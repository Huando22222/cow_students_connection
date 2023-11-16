import 'package:cow_students_connection/data/models/account.dart';
import 'package:cow_students_connection/data/models/post.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:flutter/material.dart';

class AppRepo extends ChangeNotifier {
  String? phone;
  String? password;
  String? displayName;
  String? email;
  String? id;
  String? photoUrl;
  ////////////
  account? Account;
  user? User;
}

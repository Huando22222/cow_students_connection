import 'package:cow_students_connection/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? test = "asdsaasdsddddd";
  User? get user => _user;

  String? getTest() {
    return this.test;
  }

  String? setTest(String value) {
    return this.test = value;
  }

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }
}

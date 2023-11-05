import 'dart:convert';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInApi {
  static prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }

  static void _printCredentials() {
    print(
      prettyPrint(_accessToken!.toJson()),
    );
  }

  static Map<String, dynamic>? _userData;
  static AccessToken? _accessToken;
  static bool _checking = true;
  // static final _facebookSignIn = f
  static Future<Object?> login() async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        _accessToken = result.accessToken;
        _printCredentials(); // get the user data
        // by default we get the userId, email,name and picture
        final userData = await FacebookAuth.instance.getUserData();
        // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
        _userData = userData;
        return _userData;
      } else {
        print("Login failed: ${result.message}");
        print(result.status);
      }
      // final GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount.authentication;
      // Xác thực và trả về thông tin người dùng
      return null;
    } catch (e) {
      print("Error during login facebook: $e");
      return null; // Hoặc xử lý lỗi khác tùy thuộc vào trường hợp
    }
  }
}

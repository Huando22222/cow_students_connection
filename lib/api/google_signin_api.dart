// import 'package:google_sign_in/google_sign_in.dart';

// class GoogleSignInApi {
//   static final _clientIDWeb =
//       "62520559372-832qodfslqkg2l7aqircoive1v8m4khe.apps.googleusercontent.com";
//   static final _googleSignIn = GoogleSignIn(serverClientId: _clientIDWeb);
//   // static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb); ??????????????
//   // displayName = data.displayName,
//   //email = data.email,
//   //id = data.id,
//   //photoUrl = data.photoUrl,
//   //serverAuthCode = data.serverAuthCode,
//   //_idToken = data.idToken;
//   static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
//   // if (googleSignInAccount == null) return null;
//   // final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//   static Future logout() => _googleSignIn.disconnect();
// }

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _clientIDWeb =
      "62520559372-832qodfslqkg2l7aqircoive1v8m4khe.apps.googleusercontent.com";
  static final _googleSignIn = GoogleSignIn(serverClientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() async {
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return null;
      }
      // final GoogleSignInAuthentication googleSignInAuthentication =
      //     await googleSignInAccount.authentication;
      // Xác thực và trả về thông tin người dùng
      print(googleSignInAccount);
      return googleSignInAccount;
    } catch (e) {
      print("Error during login: $e");
      return null; // Hoặc xử lý lỗi khác tùy thuộc vào trường hợp
    }
  }

  static Future logout() => _googleSignIn.disconnect();
}

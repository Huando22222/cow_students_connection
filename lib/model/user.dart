import 'package:google_sign_in/google_sign_in.dart';

class User {
  final String? displayName;
  final String? email;
  final String? id;
  final String? photoUrl;
  final String? serverAuthCode;
  final String? idToken;

  User({
    this.displayName,
    this.email,
    this.id,
    this.photoUrl,
    this.serverAuthCode,
    this.idToken,
  });

  factory User.fromGoogleSignInAccount(GoogleSignInAccount account) {
    return User(
      displayName: account.displayName,
      email: account.email,
      id: account.id,
      photoUrl: account.photoUrl,
      serverAuthCode: account.serverAuthCode,
      idToken: account.id,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginPage extends StatefulWidget {
  @override
  _FacebookLoginPageState createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  AccessToken? _accessToken;

  Future<void> _loginWithFacebook() async {
    final result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      print("_accessTokennnnnnnnnnnnnnnnnnnnnnnnnn: ${_accessToken}");
      Navigator.pop(context);
      // Đã đăng nhập thành công bằng Facebook, bạn có thể thực hiện các tác vụ khác ở đây.
    } else {
      print("Login failed: ${result.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Facebook'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_accessToken != null) Text('Logged in with Facebook!'),
            ElevatedButton(
              onPressed: _loginWithFacebook,
              child: Text('Login with Facebook'),
            ),
          ],
        ),
      ),
    );
  }
}

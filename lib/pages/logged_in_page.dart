import 'dart:convert';
import 'package:cow_students_connection/providers/account_provider.dart';
import 'package:http/http.dart' as http;
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cow_students_connection/api/google_signin_api.dart';
import 'package:provider/provider.dart';

class LoggedInPage extends StatelessWidget {
  final GoogleSignInAccount user;

  const LoggedInPage({Key? key, required this.user});
  // const LoggedInPage({super.key, required this.user});
  ////////////////////????????????????//////////////////
  @override
  Widget build(BuildContext context) {
    Future<void> registerUser() async {
      try {
        final response = await http.post(
          Uri.parse('${AppConfig.baseUrl}user/register'),
          body: {
            "phone": "",
            "password": "",
            "displayName": user.displayName,
            "email": user.email,
            "id": user.id,
            "photoUrl": user.photoUrl,
          },
        );

        if (response.statusCode == 200) {
          context.read<AppRepo>().displayName = user.displayName;
          context.read<AppRepo>().email = user.email;
          context.read<AppRepo>().id = user.id;
          context.read<AppRepo>().photoUrl = user.photoUrl;
          print("register success  ${user.id}");
        } else {
          print('Lỗi khi gửi thông tin đến máy chủ: ${response.statusCode}');
        }
      } catch (e) {
        print('Lỗi khi gửi thông tin đến máy chủ: $e');
      }
    }

    registerUser(); // Gọi hàm ngay khi trang được tạo

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Logged in"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey.shade900,
        actions: [
          TextButton(
            onPressed: () async {
              await GoogleSignInApi.logout();
              context.read<AppRepo>().displayName = "";
              context.read<AppRepo>().email = "";
              context.read<AppRepo>().id = "";
              context.read<AppRepo>().photoUrl = "";
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text("Logout"),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blueGrey.shade900,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Profile",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 32),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoUrl!),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              user.displayName!,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              user.email,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
            // Text(
            //   prettyPrint(user),
            // ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

// String prettyPrint(GoogleSignInAccount json) {
//   JsonEncoder encoder = const JsonEncoder.withIndent('  ');
//   String pretty = encoder.convert(json);
//   return pretty;
// }

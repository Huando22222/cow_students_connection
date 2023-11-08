import 'dart:convert';

import 'package:cow_students_connection/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cow_students_connection/api/google_signin_api.dart';

class LoggedInPage extends StatelessWidget {
  final GoogleSignInAccount user;

  const LoggedInPage({Key? key, required this.user});
  // const LoggedInPage({super.key, required this.user});
  ////////////////////????????????????//////////////////
  @override
  Widget build(BuildContext context) {
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

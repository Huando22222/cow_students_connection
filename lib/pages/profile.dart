import 'dart:convert';

import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/EditProfilePage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Future<user?> fetchUserData(String userId) async {
  final response =
      await http.post(Uri.parse('${AppConfig.baseUrl}/user/profile'));
  if (response.statusCode == 200) {
    return user.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load user data');
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  user? userProfile;

  @override
  void initState() {
    super.initState();
    fetchUserData('userId').then((userData) {
      setState(() {
        userProfile = userData;
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: userProfile != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("First Name: ${userProfile!.firstName}"),
                Text("Last Name: ${userProfile!.lastName}"),
                Text("Gender: ${userProfile!.gender}"),
                Text("Birthday: ${userProfile!.birthDay}"),
                Text("Avatar: ${userProfile!.avatar}"),
                Text("Phone: ${userProfile!.phone}"),
                Text("ID Account: ${userProfile!.idAcc}"),
                // Điều chỉnh để hiển thị đầy đủ thông tin người dùng
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

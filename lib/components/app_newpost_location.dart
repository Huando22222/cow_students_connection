// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/postLocation.dart';
import 'package:cow_students_connection/providers/post_location_provider.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/chat.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/styles/app_text.dart';

class AppNewPostLocation extends StatelessWidget {
  final user userProfile;
  final LatLng point;

  const AppNewPostLocation({
    Key? key,
    required this.userProfile,
    required this.point,
  }) : super(key: key);

  Future<void> _openInGoogleMaps(double latitude, double longitude) async {
    final Uri _url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');

    if (!await canLaunch(_url.toString())) {
      throw Exception('Could not launch $_url');
    } else {
      await launch(_url.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String content = '';
    uploadPostLocation() async {
      var body = {
        'owner': userProfile.id,
        'message': content,
        'latitude': point.latitude.toString(),
        'longitude': point.longitude.toString(),
      };
      final response = await http.post(
          Uri.parse('${AppConfig.baseUrl}post-location/new'),
          body: body // Thay đổi URL và endpoint của bạn
          );
      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        print("uploadPostLocation thanh cong");
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                AppAvatar(
                  pathImage: userProfile.avatar,
                  size: 75,
                ),
                SizedBox(width: 10),
                Text(
                  '${userProfile.firstName} ${userProfile.lastName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () {
                        _openInGoogleMaps(point.latitude, point.longitude);
                      },
                    ),
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Picture

                  SizedBox(height: 10),
                  // Name

                  Row(
                    children: [
                      Expanded(child: AppTextField(
                        onChanged: (value) {
                          print(value);
                          content = value;
                        },
                      )),
                      SizedBox(width: 10),
                      InkWell(
                          onTap: () {
                            print(userProfile.firstName);
                            print(content);
                            print('${point.latitude} - ${point.longitude}');

                            QuickAlert.show(
                              context: context,
                              type: QuickAlertType.confirm,
                              text: 'Sure you want to share your Location?',
                              confirmBtnText: 'Yes',
                              cancelBtnText: 'No',
                              confirmBtnColor: Colors.green,
                              onConfirmBtnTap: () {
                                if (context
                                        .read<PostLocationProvider>()
                                        .isPosted ==
                                    false) {
                                  uploadPostLocation();
                                }
                              },
                            );
                          },
                          child: Icon(Icons.rocket_launch)),
                    ],
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

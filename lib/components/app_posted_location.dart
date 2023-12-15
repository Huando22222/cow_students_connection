// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/chat.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/styles/app_text.dart';

class AppPostedLocation extends StatelessWidget {
  final user userProfile;
  final LatLng point;
  final String mess;

  const AppPostedLocation({
    Key? key,
    required this.userProfile,
    required this.point,
    required this.mess,
  }) : super(key: key);
  void callPhoneNumber(String phoneNumber) async {
    final Uri _url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

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
                      icon: Icon(Icons.message),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatPage()),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () {
                        _openInGoogleMaps(point.latitude, point.longitude);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
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

                  Column(
                    children: [
                      Text(
                        mess,
                        style: AppText.header2,
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.phone),
                        title: Text('Phone'),
                        subtitle: Row(
                          children: [
                            Text('${userProfile.phone}'),
                            SizedBox(width: 10),
                            IconButton(
                              icon: Icon(Icons.call),
                              onPressed: () {
                                callPhoneNumber('${userProfile.phone!}');
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

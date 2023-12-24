// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/components/app_user_profileInfo.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/room.dart';
import 'package:cow_students_connection/pages/location.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/providers/post_location_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart' as http;
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/chat/chat_to_person.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/styles/app_text.dart';

class AppPostedLocation extends StatelessWidget {
  final user userProfile;
  final LatLng point;
  final String mess;
  final String postId;

  const AppPostedLocation({
    Key? key,
    required this.userProfile,
    required this.point,
    required this.mess,
    required this.postId,
  }) : super(key: key);
  void callPhoneNumber(String phoneNumber) async {
    final Uri _url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void deletePost(BuildContext context) async {
    try {
      // Xóa post
      var response = await http.post(
        Uri.parse('${AppConfig.baseUrl}post-location/delete'),
        body: {'postId': postId},
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        // Quay lại trang Location để cập nhật UI
      } else {
        // Xử lý lỗi khi xóa không thành công
      }
    } catch (error) {
      // Xử lý exception khi xóa bị lỗi
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
                  onImagePicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            UserProfileInfo(userProfile: userProfile),
                      ),
                    );
                  },
                  pathImage: userProfile.avatar,
                ),
                SizedBox(width: 10),
                Text(
                  '${userProfile.firstName} ${userProfile.lastName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // SizedBox(width: 10),
                Spacer(),
                Row(
                  children: [
                    Visibility(
                      visible:
                          context.watch<AppRepo>().User!.id != userProfile.id,
                      child: IconButton(
                        icon: Icon(Icons.message),
                        onPressed: () {
                          String unRoom = "unRoom";
                          List<room> listRooms =
                              context.read<ChatProvider>().rooms;
                          for (var room in listRooms) {
                            for (var user in room.users) {
                              if (user.id == userProfile.id) {
                                unRoom = room.id;
                              }
                            }
                          }
                          ////////////////////////////
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatToPerson(
                                // titleAppBar: chatTo,
                                userInfo: userProfile,
                                room: unRoom,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () {
                        _openInGoogleMaps(point.latitude, point.longitude);
                      },
                    ),
                    Visibility(
                      visible:
                          context.watch<AppRepo>().User!.id == userProfile.id,
                      child: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.warning,
                            text: 'Sure you want to delete Location?',
                            confirmBtnText: 'Yes',
                            // cancelBtnText: 'No',
                            confirmBtnColor: Color.fromARGB(255, 200, 182, 47),
                            onConfirmBtnTap: () {
                              deletePost(context);
                            },
                          );
                        },
                      ),
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

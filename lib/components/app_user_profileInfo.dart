import 'dart:io';
import 'package:cow_students_connection/pages/chat/chat_to_person.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/providers/app_repo.dart';

class UserProfileInfo extends StatelessWidget {
  final user userProfile;
  final Function()? onEditProfile;
  final Function()? onPickImage;

  const UserProfileInfo({
    required this.userProfile,
    this.onEditProfile,
    this.onPickImage,
  });
  void callPhoneNumber(String phoneNumber) async {
    final Uri _url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://img4.thuthuatphanmem.vn/uploads/2020/05/13/anh-nen-4k-anime_062606240.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: MediaQuery.of(context).size.width / 3,
                    child: AppAvatar(
                      pathImage: userProfile.avatar,
                      size: 150,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${userProfile!.firstName} ${userProfile!.lastName}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (onEditProfile != null)
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                onEditProfile!();
                              },
                            ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: Icon(Icons.message),
                              onPressed: () {
                                /////////////////////////////////Find out if the user was in the same room
                                // String room = "unRoom";
                                // // room? matchingRoom;
                                // var matchingRoom = context
                                //     .read<ChatProvider>()
                                //     .rooms
                                //     .where(
                                //       (item) => item.users.any(
                                //           (user) => user.id == userProfile.id),
                                //     );
                                // if (matchingRoom.isNotEmpty) {
                                //   // print("====================================");
                                //   room = matchingRoom.first.id;
                                // }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Consumer<ChatProvider>(
                                      builder: (context, value, child) {
                                        String room = "unRoom";
                                        // room? matchingRoom;
                                        var matchingRoom = context
                                            .read<ChatProvider>()
                                            .rooms
                                            .where(
                                              (item) => item.users.any((user) =>
                                                  user.id == userProfile.id),
                                            );
                                        if (matchingRoom.isNotEmpty) {
                                          room = matchingRoom.first.id;
                                        }
                                        return ChatToPerson(
                                          userInfo: userProfile,
                                          room: room,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Insert Bio Here',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.person_rounded),
                    title: Text('Gender'),
                    subtitle: Text('${userProfile!.gender}'),
                  ),
                  ListTile(
                    leading: Icon(Icons.cake),
                    title: Text('Birthday'),
                    subtitle: Text('${userProfile!.birthDay!.day}' +
                        '/' +
                        '${userProfile!.birthDay!.month}' '/' +
                        '${userProfile!.birthDay!.year}'),
                  ),
                  ListTile(
                    leading: InkWell(
                        onTap: () {
                          callPhoneNumber('${userProfile!.phone!}');
                        },
                        child: Icon(Icons.phone)),
                    title: Text('Phone'),
                    subtitle: Row(
                      children: [
                        Text('${userProfile!.phone}'),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.info_rounded),
                    title: Text('ID Account'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${userProfile!.idAcc}'),
                        SizedBox(height: 5),
                        QrImageView(
                          data: '${userProfile!.idAcc}',
                          version: QrVersions.auto,
                          size: 200.0,
                        ),
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () {
                            onPickImage!();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

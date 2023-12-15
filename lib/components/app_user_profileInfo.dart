import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200, // Điều chỉnh chiều cao của ảnh bìa tại đây
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://img4.thuthuatphanmem.vn/uploads/2020/05/13/anh-nen-4k-anime_062606240.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 120,
                left: MediaQuery.of(context).size.width / 2 - 190,
                child: AppAvatar(
                  pathImage: userProfile.avatar,
                  size: 150,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Picture

                    SizedBox(height: 250),
                    // Name
                    Row(
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
                      ],
                    ),

                    Text(
                      'Insert Bio Here',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Divider(), // A line to separate sections
                    // More details about the user
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
                      leading: Icon(Icons.phone),
                      title: Text('Phone'),
                      subtitle: Row(
                        children: [
                          Text('${userProfile!.phone}'),
                          SizedBox(width: 10),
                          IconButton(
                            icon: Icon(Icons.call),
                            onPressed: () {
                              callPhoneNumber('${userProfile!.phone!}');
                            },
                          ),
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
                    // Add more ListTile widgets for additional details

                    // You can add a Friends List, Posts, or other sections related to a Facebook profile
                  ],
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

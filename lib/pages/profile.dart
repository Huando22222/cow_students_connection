import 'dart:convert';
import 'dart:io';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/EditProfilePage.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  user? userProfile;
  File? avatar;
  @override
  void initState() {
    super.initState();
    userProfile = context.read<AppRepo>().User;
  }

  void callPhoneNumber(String phoneNumber) async {
    final Uri _url = Uri.parse('tel:$phoneNumber');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  void pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final imageTemporary = File(image.path);

      this.avatar = imageTemporary;
      setState(() {});
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  void editProfile() {
    // Navigate to the EditProfilePage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfilePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Ảnh bìa
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
                  top: 120,
                  left: MediaQuery.of(context).size.width / 2 - 190,
                  child: CircleAvatar(
                    radius: 80,
                    child: AppAvatar(
                      pathImage: context.read<AppRepo>().User!.avatar,
                      size: 1000,
                      onImagePicked: pickImage,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 250),
                      Row(
                        children: [
                          Text(
                            '${userProfile!.firstName} ${userProfile!.lastName}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              editProfile();
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
                        leading: Icon(Icons.phone),
                        title: Text('Phone'),
                        subtitle: Row(
                          children: [
                            Text('${userProfile!.phone}'),
                            SizedBox(width: 10),
                            IconButton(
                              icon: Icon(Icons.call),
                              onPressed: () {
                                callPhoneNumber('${userProfile!.phone}');
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
                                pickImage();
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
          ],
        ),
      ),
    );
  }
}

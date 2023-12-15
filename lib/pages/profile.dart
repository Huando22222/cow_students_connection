import 'dart:io';

import 'package:cow_students_connection/components/app_user_profileInfo.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/EditProfilePage.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
    return UserProfileInfo(
      userProfile: userProfile!,
      onEditProfile: editProfile,
      onPickImage: pickImage,
    );
  }
}

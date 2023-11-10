import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AppPostNews extends StatefulWidget {
  const AppPostNews({super.key});

  @override
  State<AppPostNews> createState() => _AppPostNewsState();
}

class _AppPostNewsState extends State<AppPostNews> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future<void> uploadImages(File imageFile) async {
    final uri = Uri.parse(
        '${AppConfig.baseUrl}post/new'); // Replace with your server endpoint
    final request = http.MultipartRequest('POST', uri);

    // // Add text fields to the request
    // request.fields['ownerId'] = 'huan';
    // request.fields['message'] = 'eating pho at hanoi';
    // request.fields['likes'] = '12';

    request.files.add(http.MultipartFile(
      'images',
      http.ByteStream(imageFile.openRead()),
      await imageFile.length(),
      // filename: 'image.jpg',
      filename: '${context.read<AppRepo>().Account!.id}.jpg',
      contentType: MediaType('image', 'jpg'),
    ));

    try {
      final response = await http.Response.fromStream(await request.send());
      print("user: ${context.read<AppRepo>().Account!.phone}");
      print("id user: ${context.read<AppRepo>().Account!.id}");

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading image: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    TextEditingController _contentPost = TextEditingController();
    return Column(
      children: [
        Row(
          children: [
            AppAvatar(),
            Expanded(
              child: TextField(
                controller: _contentPost,
                decoration: InputDecoration(hintText: "what's news "),
              ),
            ),
            InkWell(
              onTap: () => pickImage(ImageSource.gallery),
              child: ClipOval(
                child: Image.asset(
                  "assets/images/gallery.png",
                  height: 50,
                  width: 50,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        if (image != null)
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Image.file(
              image!,
              height: 200,
              width: screenWidth,
              fit: BoxFit.scaleDown,
            ),
          ),
      ],
    );
  }
}

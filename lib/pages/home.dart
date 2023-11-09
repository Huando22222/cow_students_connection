import 'dart:io';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        'http://192.168.1.47:3000/post/new'); // Replace with your server endpoint
    final request = http.MultipartRequest('POST', uri);

    request.files.add(http.MultipartFile(
      'images',
      http.ByteStream(imageFile.openRead()),
      await imageFile.length(),
      filename: 'image.jpg',
      contentType: MediaType('image', 'jpg'),
    ));
    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        // Handle success response from the server
      } else {
        print('Failed to upload image. Status code: ${response.statusCode}');
        // Handle error response from the server
      }
    } catch (error) {
      print('Error uploading image: $error');
      // Handle other errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                      onPressed: () => pickImage(ImageSource.gallery),
                      child: Text("gallery")),
                  // ElevatedButton(onPressed: () {}, child: Text("camera")),
                  ClipOval(
                    child: image != null
                        ? Image.file(
                            image!,
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          )
                        : Text("Pick a image"),
                  ),
                  ElevatedButton(
                      onPressed: () async => await uploadImages(image!),
                      child: Text("upload")),

                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/a/ACg8ocLpe7gtoB_VZVctyQWGSopavvEChqok_UOJC0jEvqiV=s96-c",
                        ),
                      ),
                      Column(
                        children: [
                          Text("Killjoy"),
                          Text("14m"),
                        ],
                      ),
                    ],
                  ),
                  Text("eating pho in hanoi"),
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        "https://cdn.pastaxi-manager.onepas.vn/content/uploads/articles/01-Phuong-Mon%20ngon&congthuc/1.%20pho%20ha%20noi/canh-nau-pho-ha-noi-xua-mang-huong-vi-kinh-do-cua-80-nam-ve-truoc-1.jpg",
                      ),
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

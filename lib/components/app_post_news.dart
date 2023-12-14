import 'dart:convert';

import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/post.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:provider/provider.dart';

class AppPostNews extends StatefulWidget {
  const AppPostNews({Key? key}) : super(key: key);

  @override
  State<AppPostNews> createState() => _AppPostNewsState();
}

class _AppPostNewsState extends State<AppPostNews> {
  File? image;
  TextEditingController _contentPost = TextEditingController();
  String? content = "";
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

  Future<void> uploadImages(File? imageFile) async {
    final uri = Uri.parse('${AppConfig.baseUrl}post/new');
    final request = http.MultipartRequest('POST', uri);

    // Thêm các trường văn bản vào yêu cầu
    request.fields['owner'] = context.read<AppRepo>().User!.id!;
    request.fields['message'] = _contentPost.text;
    // request.fields['likes'] = '0';

    // Kiểm tra xem có hình ảnh hay không trước khi thêm vào yêu cầu
    if (imageFile != null) {
      request.files.add(http.MultipartFile(
        'images',
        http.ByteStream(imageFile.openRead()),
        await imageFile.length(),
        filename: '${context.read<AppRepo>().User!.id}=.jpg',
        contentType: MediaType('image', 'jpg'),
      ));
    }

    try {
      print('Tuan ID ${context.read<AppRepo>().User!.id!}');
      print('Tuan aNh ${imageFile}');
      print('Tuan NoiDung ${_contentPost.text}');
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        print('Post uploaded successfully');
        final responseData = jsonDecode(response.body);
        post newPost = post.fromJson(responseData['post']);
        context.read<PostProvider>().addPost(newPost);
        removeImage();
        _contentPost.text = "";
        print('Fname ${newPost.message}');
      } else {
        print('Failed to upload post. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading post: $error');
    }
  }

  void removeImage() {
    setState(() {
      image = null;
    });
  }

  bool canPost() {
    return (_contentPost.text.trim().isNotEmpty || image != null);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            AppAvatar(pathImage: context.read<AppRepo>().User!.avatar),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _contentPost,
                onChanged: (value) {
                  setState(() {}); // Trigger a rebuild when text changes
                },
                decoration: InputDecoration(hintText: "what's news "),
                maxLines: null,
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
          GestureDetector(
            onTap: () {
              // Handle the image zoom-in or any other action
            },
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Image.file(
                    image!,
                    height: 200,
                    width: screenWidth,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: removeImage,
                ),
              ],
            ),
          ),
        Visibility(
          visible: canPost(),
          child: AnimatedOpacity(
            opacity: canPost() ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: IgnorePointer(
              ignoring: !canPost(),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 44, 176, 117),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            topLeft: Radius.circular(20)),
                      ),
                    ),
                    onPressed: () {
                      if (canPost()) {
                        // Call the uploadImages function here
                        uploadImages(image);
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text("Đăng bài"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Hiển thị nút "Đăng bài" chỉ khi có nội dung hoặc hình ảnh
        // AnimatedOpacity(
        //   opacity: canPost() ? 1.0 : 0.0,
        //   duration: Duration(milliseconds: 500),
        //   child: IgnorePointer(
        //     ignoring: !canPost(),
        //     child: Align(
        //       alignment: Alignment.bottomCenter,
        //       child: Container(
        //         child: ElevatedButton(
        //           style: ElevatedButton.styleFrom(
        //             primary: Color.fromARGB(255, 44, 176, 117),
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.only(
        //                   bottomRight: Radius.circular(20),
        //                   topLeft: Radius.circular(20)),
        //             ),
        //           ),
        //           onPressed: () {
        //             if (canPost()) {
        //               // Call the uploadImages function here
        //               uploadImages(image);
        //             }
        //           },
        //           child: Padding(
        //             padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        //             child: Text("Đăng bài"),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

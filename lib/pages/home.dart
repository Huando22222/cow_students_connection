import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PostScreen(),
    );
  }
}

Future<void> checkPermission() async {
  var statuses = await [
    Permission.camera,
    Permission.microphone,
    Permission.location,
  ].request();

  bool allGranted = statuses.values.every((status) => status.isGranted);

  if (!allGranted) {
    // Handle cases where permissions are not granted.
  }
}

class Post {
  String content;
  DateTime timestamp;
  String? imagePath;

  Post(this.content, this.timestamp, {this.imagePath});
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController _postController = TextEditingController();
  final List<Post> _posts = [];
  XFile? _image;

  void _submitPost() {
    final content = _postController.text;
    if (content.isNotEmpty || _image != null) {
      final newPost = Post(content, DateTime.now(), imagePath: _image?.path);
      setState(() {
        _posts.add(newPost);
        _postController.clear();
        _image = null;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đăng bài viết'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Khung viết bài viết
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _postController,
                decoration: InputDecoration(
                  hintText: 'Bạn đang nghĩ gì?',
                ),
                maxLines: null,
              ),
            ),
            SizedBox(height: 16.0),
            // Nút chọn ảnh
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Chọn ảnh'),
            ),
            // Hiển thị ảnh đã chọn (nếu có)
            if (_image != null)
              Image.file(
                File(_image!.path),
                height: 150,
                width: 150,
              ),
            SizedBox(height: 16.0),
            // Nút Đăng bài viết
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('Đăng'),
            ),
            SizedBox(height: 16.0),
            // Danh sách các bài viết
            Expanded(
              child: ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(_posts[index].content),
                        ),
                        // Hiển thị hình ảnh (nếu có)
                        if (_posts[index].imagePath != null)
                          File(_posts[index].imagePath!).existsSync()
                              ? Image.file(File(_posts[index].imagePath!))
                              : Text("Lỗi: Không tìm thấy hình ảnh"),

                        // Hiển thị nội dung và thời gian dưới hình ảnh
                        ListTile(
                          subtitle: Text(_posts[index].timestamp.toString()),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

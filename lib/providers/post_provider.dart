import 'package:cow_students_connection/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cow_students_connection/data/models/post.dart';

class PostProvider extends ChangeNotifier {
  List<post> Posts = [];
  //List<post> get posts => Posts;

  void addPost(post newPost) {
    Posts.insert(0, newPost);
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    print("get refresh");
    List<post> fetchedPosts = [];
    try {
      final response = await http.get(Uri.parse('${AppConfig.baseUrl}post/'));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Posts.clear();
        Posts = (responseData["data"] as List)
            .map((data) => post.fromJson(data))
            .toList();
        print("pót lengh: ${Posts.length}");

        notifyListeners();
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching posts OUT SIDE TRY: $error');
    }
  }
}

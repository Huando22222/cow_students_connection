import 'package:cow_students_connection/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cow_students_connection/data/models/post.dart';

class PostProvider extends ChangeNotifier {
  List<post> Posts = [];
  //List<post> get posts => Posts;

  void addPost(post newPost) {
    Posts.insert(0, newPost); // Add the new post at the beginning of the list
    notifyListeners();
    // Notify listeners that the data has changed
  }

  Future<void> fetchPosts() async {
    print("get refresh");
    List<post> fetchedPosts = [];
    try {
      // final response = await http.get(Uri.parse('${AppConfig.baseUrl}post/'));
      // if (response.statusCode == 200) {
      //   print("success fetch: "); //${Posts.length}
      //   List<post> fetchedPosts = (jsonDecode(response.body) as List)
      //       .map((data) => post.fromJson(data))
      //       .toList();
      final response = await http.get(Uri.parse('${AppConfig.baseUrl}post/'));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Posts.clear();
        Posts = (responseData["data"] as List)
            .map((data) => post.fromJson(data))
            .toList();
        print("pót lengh: ${Posts.length}");
//////////////////////////////////////////////////////////
        // Posts.clear();
        // Posts.addAll(fetchedPosts);
        // print("${response.body}"); //${Posts.length}
        ////test
        // for (var post in Posts) {
        //   print("Message: ${post.images}");
        //   print("Message: ${post.owner!.avatar}");
        //   // In ra các thông tin khác của post nếu cần
        // }
        notifyListeners();
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching posts OUT SIDE TRY: $error');
    }
  }
}

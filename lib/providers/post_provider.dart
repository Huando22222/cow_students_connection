import 'package:cow_students_connection/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cow_students_connection/data/models/post.dart';
import 'package:pinput/pinput.dart';

class PostProvider extends ChangeNotifier {
  final List<post> Posts = [];

  Future<void> fetchPosts() async {
    try {
      // final response = await http.get(Uri.parse('${AppConfig.baseUrl}post/'));
      // if (response.statusCode == 200) {
      //   print("success fetch: "); //${Posts.length}
      //   List<post> fetchedPosts = (jsonDecode(response.body) as List)
      //       .map((data) => post.fromJson(data))
      //       .toList();
      final response = await http.get(Uri.parse('${AppConfig.baseUrl}post/'));
      if (response.statusCode == 200) {
        print("success fetch: "); //${Posts.length}
        final responseData = jsonDecode(response.body);
  List.generate(responseData['data'], (index) => null)
        post.fromJson(responseData['data']);
        Posts.addAll(Post);

//////////////////////////////////////////////////////////
        Posts.clear();
        Posts.addAll(fetchedPosts);
        print("${response.body}"); //${Posts.length}
        for (var post in Posts) {
          print("Message: ${post.message}");
          // In ra các thông tin khác của post nếu cần
        }
        notifyListeners();
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching posts OUT SIDE TRY: $error');
    }
  }
}

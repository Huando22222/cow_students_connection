import 'package:cow_students_connection/data/models/post.dart';
import 'package:flutter/material.dart';

class AppPost extends ChangeNotifier {
  //post? Post;
  List<post> newsList = [];
   void addNews(post news) {
    newsList.add(news);
    notifyListeners();
  }
}

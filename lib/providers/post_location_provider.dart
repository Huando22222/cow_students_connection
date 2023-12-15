import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/postLocation.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cow_students_connection/data/models/post.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class PostLocationProvider extends ChangeNotifier {
  List<postLocation> PostLocations = [];
  bool isPosted = false;
  //List<post> get posts => Posts;

  // void addPostlocation(postLocation newPost) {
  //   PostLocations.insert(0, newPost);
  //   notifyListeners();
  // }

  Future<void> fetchPosts(BuildContext context) async {
    print("get refresh location");

    // List<postLocation> fetchedPosts = [];
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}post-location/'));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        PostLocations.clear();
        PostLocations = (responseData["data"] as List)
            .map((data) => postLocation.fromJson(data))
            .toList();
        print("pót lengh: ${PostLocations[0].id} -k ${PostLocations.length}");

        if (PostLocations.any((location) =>
            location.owner!.id == context.read<AppRepo>().User!.id)) {
          isPosted = true;
          print("hás dataaaaaaaaaaaaaaaaaaaaaaaaaa ${isPosted}");
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

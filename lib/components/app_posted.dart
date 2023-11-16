import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/post.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';

class AppPosted extends StatelessWidget {
  // final String? ownerName;
  // final DateTime? created;
  // final String? content;
  // final String? images;
  final post Post;
  // final post post; // not a type
  const AppPosted({
    super.key,
    required this.Post,
    // required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // AppAvatar(pathImage: Post.owner!.avatar),
              AppAvatar(
                pathImage: Post.owner!.avatar,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${Post.owner!.firstName} ${Post.owner!.lastName}"),
                  Text(
                    "${Post.createdAt!.hour}:${Post.createdAt!.minute}",
                    style: AppText.note,
                  ),
                ],
              ),
            ],
          ),
          // parameters post & user
          if (Post.message != "")
            Text(
              Post.message!,
              style: Post.images != "" ? AppText.subtitle1 : AppText.header2,
            ),
          if (Post.images != "")
            SizedBox(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  "${AppConfig.baseUrl}images/${Post.images}",
                  height: 250,
                  width: 350,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/post.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';

class AppPosted extends StatelessWidget {
  final String? content;
  final String? images;
  // final post post; // not a type
  const AppPosted({
    super.key,
    this.images,
    this.content,
    // required this.post
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppAvatar(),
                  Column(
                    children: [
                      Text("Killjoy"),
                      Text("14m"),
                    ],
                  ),
                ],
              ),
              // parameters post & user
              if (content != null) Text(content!, style: AppText.subtitle1),
              if (images != null)
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      images!,
                    ),
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}

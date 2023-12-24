import 'package:cow_students_connection/components/ZoomedImageDialog.dart';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/app_user_profileInfo.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(5), // Thêm borderRadius vào đây
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 5.0, right: 5, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserProfileInfo(userProfile: Post.owner!)));
              },
              child: Row(
                children: [
                  // AppAvatar(pathImage: Post.owner!.avatar),
                  AppAvatar(
                    // onImagePicked: () {
                    //   // Navigator.push(
                    //   //     context,
                    //   //     MaterialPageRoute(
                    //   //         builder: (context) =>
                    //   //             UserProfileInfo(userProfile: Post.owner!)));
                    // },
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
            ),
            // parameters post & user
            if (Post.message != "")
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5),
                child: Text(
                  Post.message!,
                  style:
                      Post.images != "" ? AppText.subtitle1 : AppText.header2,
                ),
              ),
            SizedBox(
              height: 8,
            ),
            if (Post.images != "")
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return ZoomedImageScreen(
                        imageUrl: "${AppConfig.baseUrl}images/${Post.images}",
                        onClose: () {
                          Navigator.of(context).pop(); // Đóng màn hình phóng to
                        },
                      );
                    },
                  ));
                },
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
      ),
    );
  }
}

import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:flutter/material.dart';

class AvatarContainer extends StatelessWidget {
  final String pathImage;

  const AvatarContainer({Key? key, required this.pathImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        border: Border.all(
          color: Colors.lightBlueAccent,
          width: 4,
        ),
      ),
      child: AppAvatar(
        pathImage: pathImage,
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class AppAvatar extends StatefulWidget {
  final double? size;
  final String? pathImage;
  final void Function()? onImagePicked;
  final File? image;
  const AppAvatar({
    Key? key,
    this.size,
    this.pathImage,
    this.onImagePicked,
    this.image,
  }) : super(key: key);

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  // File? image;
  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return null;

  //     final imageTemporary = File(image.path);
  //     setState(() {
  //       this.image = imageTemporary;
  //       widget.onImagePicked?.call(imageTemporary);
  //     });
  //   } on PlatformException catch (e) {
  //     print("Failed to pick image: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double? sized = widget.size ?? 40;
    return ClipOval(
      child: InkWell(
        onTap: widget.onImagePicked,
        child: widget.pathImage != null
            ? Image.network(
                widget.pathImage!,
                height: sized,
                width: sized,
                fit: BoxFit.cover,
              )
            : widget.image != null
                ? Image.file(
                    widget.image!,
                    height: sized,
                    width: sized,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/default_avatar.png",
                    height: sized,
                    width: sized,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class AppAvatar extends StatefulWidget {
  final double? size;
  final String? pathImage;
  final Function(File?)? onImagePicked;
  const AppAvatar({
    Key? key,
    this.size,
    this.pathImage,
    this.onImagePicked,
  }) : super(key: key);

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return null;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
        widget.onImagePicked?.call(imageTemporary);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        pickImage(ImageSource.gallery);
      },
      child: ClipOval(
        child: widget.pathImage != null
            ? Image.network(
                widget.pathImage!,
                height: widget.size ?? 40,
                width: widget.size ?? 40,
                fit: BoxFit.cover,
              )
            : image != null
                ? Image.file(
                    image!,
                    height: widget.size ?? 40,
                    width: widget.size ?? 40,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    "assets/images/default_avatar.png",
                    height: widget.size ?? 40,
                    width: widget.size ?? 40,
                    fit: BoxFit.cover,
                  ),
      ),
    );
  }
}

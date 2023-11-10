import 'dart:io';

import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppAvatar extends StatefulWidget {
  final double? size;
  final String? image;
  final File? fileImage;
  final Function()? onTap;
  const AppAvatar({Key? key, this.size, this.image, this.onTap, this.fileImage})
      : super(key: key);

  @override
  State<AppAvatar> createState() => _AppAvatarState();
}

class _AppAvatarState extends State<AppAvatar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap != null ? widget.onTap : null,
      child: ClipOval(
        child: widget.fileImage != null
            ? Image.file(
                widget.fileImage!,
                height: widget.size ?? 40,
                width: widget.size ?? 40,
                fit: BoxFit.cover,
              )
            : widget.image == null
                ? Image.asset(
                    "assets/images/default_avatar.png",
                    height: widget.size ?? 40,
                    width: widget.size ?? 40,
                    fit: BoxFit.cover,
                  )
                : Image.network("${widget.image}"),
      ),
    );
  }
}

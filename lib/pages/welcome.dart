import 'dart:io';
import 'dart:convert';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/app_text_field_icon.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:cow_students_connection/helper/image_picker_helper.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  // Thêm hàm khởi tạo để khởi tạo ImagePickerHelper
  @override
  Widget build(BuildContext context) {
    final ImagePickerHelper _imagePickerHelper = ImagePickerHelper(context);
    // Khởi tạo ImagePickerHelper
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<AppRepo>(
                      builder: (context, appRepo, child) {
                        return AppAvatar(
                          size: 200,
                          onTap: () {
                            _imagePickerHelper.pickImage(ImageSource.gallery);
                          },
                          fileImage: appRepo.imageFile,
                        );
                      },
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 200,
                      child: TextField(),
                    ),
                    Text("asdasd"),
                    // AppTextFieldIcon(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

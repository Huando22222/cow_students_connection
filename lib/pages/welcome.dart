import 'dart:io';
import 'dart:convert';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/app_button.dart';
import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/components/date_time_picker.dart';
import 'package:cow_students_connection/components/dropdown_button.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/app_temp.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import "package:cow_students_connection/helper/image_picker_helper.dart";
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import "package:cow_students_connection/providers/temp/app_temp_value.dart";
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  // Thêm hàm khởi tạo để khởi tạo ImagePickerHelper
  var firstName;
  var lastName;
  var phone;
  File? avatar;
  DateTime? birthDay;
  String selectedGender = '';
  var dropdownValue = "gender";
  final genders = ['Male', 'Female', 'Other'];

  // late ImagePickerHelper _imagePickerHelper;
  @override
  void initState() {
    super.initState();
  }

  void pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;

      final imageTemporary = File(image.path);

      this.avatar = imageTemporary;
      setState(() {});
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Khởi tạo ImagePickerHelper
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  AppAvatar(
                    size: 200,
                    onImagePicked: pickImage,
                    image: avatar,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        hint: "F name",
                        sizedWidth: 150,
                        onChanged: (value) {
                          firstName = value;
                        },
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      AppTextField(
                        hint: "F name",
                        sizedWidth: 150,
                        onChanged: (value) {
                          lastName = value;
                        },
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButtonCustom(
                        items: genders,
                        placeholder: dropdownValue,
                        onGenderSelected: (value) {
                          selectedGender = value;
                        },
                      ),
                      DateTimePicker(
                        onDateTimeChanged: (DateTime value) {
                          birthDay = value;
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "phone",
                    showLabel: false,
                    keyboardType: TextInputType.number,
                    svgPicture: "assets/images/ic_phone.svg",
                    onChanged: (value) {
                      print(phone);
                      phone = value;
                    },
                  ),
                  Spacer(),
                  AppButton(
                    text: "Create",
                    onPressed: () async {
                      final uri = Uri.parse('${AppConfig.baseUrl}user/profile');
                      final request = http.MultipartRequest('POST', uri);

                      request.fields['firstName'] = firstName;
                      request.fields['lastName'] = lastName;
                      request.fields['birthDay'] = birthDay!.toIso8601String();
                      request.fields['gender'] = selectedGender;
                      request.fields['phone'] = phone;
                      request.fields['idAcc'] =
                          context.read<AppRepo>().Account!.idAcc;

                      request.files.add(http.MultipartFile(
                        'avatar',
                        http.ByteStream(avatar!.openRead()),
                        await avatar!.length(),
                        // filename: 'image.jpg',
                        filename:
                            '${context.read<AppRepo>().Account!.idAcc}.jpg',
                        contentType: MediaType('image', 'jpg'),
                      ));

                      try {
                        final response = await http.Response.fromStream(
                            await request.send());

                        if (response.statusCode == 200) {
                          final responseData = jsonDecode(response.body);
                          context.read<AppRepo>().User =
                              user.fromJson(responseData["user"]);
                          print(
                              'updated profile ${context.read<AppRepo>().User!.id} \n ${context.read<AppRepo>().User!.birthDay}');
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.main);
                        } else {
                          print(
                              'Failed to updated profxile Status code: ${response.statusCode}');
                        }
                      } catch (error) {
                        print('Error uploading image: $error');
                      }
                      print(
                          "F&L:${firstName} ${lastName} Bd:${birthDay?.toIso8601String()} gender:${selectedGender}  phone:${phone}  avt:${avatar} idAcc:${context.read<AppRepo>().Account!.idAcc}");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

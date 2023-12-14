import 'dart:convert';
import 'dart:io';
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/app_button.dart';
import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/components/date_time_picker.dart';
import 'package:cow_students_connection/components/dropdown_button.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/pages/main_page.dart';
import 'package:cow_students_connection/pages/profile.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  var firstName;
  user? userProfile;
  var lastName;
  var phone;
  File? avatar;
  DateTime? birthDay;
  String selectedGender = '';
  var dropdownValue = "gender";
  final genders = ['Male', 'Female', 'Other'];
  user? currentUser;
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
    //  firstName = context.read<AppRepo>().User!.firstName;
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
                    //  pathImage: "${context.read<AppRepo>().User!.avatar}",
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppTextField(
                        // controller: TextEditingController(text: firstName),
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
                        //controller: TextEditingController(text: lastName),
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
                    //  controller: TextEditingController(text: phone),
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
                      text: "Update",
                      onPressed: () async {
                        _updateProfileInfo();
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _updateProfileInfo() async {
    final uri = Uri.parse('${AppConfig.baseUrl}user/profileUpdate');
    print('${AppConfig.baseUrl}user/profileUpdate');
    final request = http.MultipartRequest('POST', uri);

    if (firstName != null && firstName.isNotEmpty) {
      request.fields['firstName'] = firstName;
    }
    if (lastName != null && lastName.isNotEmpty) {
      request.fields['lastName'] = lastName;
    }
    if (phone != null && phone.isNotEmpty) {
      request.fields['phone'] = phone;
    }
    if (birthDay != null && birthDay!.day != 0) {
      request.fields['birthDay'] = birthDay!.toIso8601String();
    }
    if (selectedGender != null && selectedGender.isNotEmpty) {
      request.fields['gender'] = selectedGender;
    }

    if (avatar != null && avatar!.lengthSync() > 0) {
      // If avatar exists, include it in the request
      request.fields['idAcc'] = context.read<AppRepo>().Account!.idAcc;
      request.files.add(http.MultipartFile(
        'avatar',
        http.ByteStream(avatar!.openRead()),
        await avatar!.length(),
        filename: '${context.read<AppRepo>().Account!.idAcc}.jpg',
        contentType: MediaType('image', 'jpg'),
      ));
    } else {
      // If no avatar is selected, proceed without attaching an avatar
      request.fields['idAcc'] = context.read<AppRepo>().Account!.idAcc;
    }

    try {
      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        context.read<AppRepo>().User = user.fromJson(responseData["user"]);
        print(
            'Updated profile ${context.read<AppRepo>().User!.id} \n ${context.read<AppRepo>().User!.birthDay}');
        Navigator.of(context).pushReplacementNamed(AppRoutes.main);
      } else {
        print('Failed to update profile Status code: ${response.statusCode}');
        // Xử lý lỗi hoặc thông báo cho người dùng nếu cập nhật không thành công
      }
    } catch (error) {
      print('Error updating profile: $error');
      // Xử lý lỗi hoặc thông báo cho người dùng nếu có lỗi xảy ra trong quá trình gửi request
    }
  }
}

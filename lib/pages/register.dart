import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cow_students_connection/components/app_button.dart';
import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/config/app_icon.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isConfirmed = false;
  bool isFullnameFilled = false;
  bool isUsernameFilled = false;
  bool isPasswordFilled = false;
  bool isPhoneFilled = false;
  bool isEmailFilled = false;

  @override
  Widget build(BuildContext context) {
    bool isAllFieldsFilled = isFullnameFilled &&
        isUsernameFilled &&
        isPasswordFilled &&
        isPhoneFilled &&
        isEmailFilled;

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/logoHutech.svg",
                      width: 100, // Đặt chiều rộng mong muốn
                      height: 100,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "From students\nto students",
                      style: AppText.header2,
                    ),
                  ],
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(hintText: "Fullname"),
                  onChanged: (text) {
                    setState(() {
                      isFullnameFilled = text.isNotEmpty;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Username"),
                  onChanged: (text) {
                    setState(() {
                      isUsernameFilled = text.isNotEmpty;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Password"),
                  onChanged: (text) {
                    setState(() {
                      isPasswordFilled = text.isNotEmpty;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Phone"),
                  onChanged: (text) {
                    setState(() {
                      isPhoneFilled = text.isNotEmpty;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  decoration: InputDecoration(hintText: "Email"),
                  onChanged: (text) {
                    setState(() {
                      isEmailFilled = text.isNotEmpty;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isConfirmed ?? false,
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          // Kiểm tra giá trị newValue có null hay không
                          setState(() {
                            isConfirmed = newValue;
                          });
                        }
                      },
                    ),
                    Text(
                      "Confirm",
                      style: AppText.body1, // Điều chỉnh kiểu chữ theo nhu cầu
                    ),
                  ],
                ),
                Spacer(),
                AppButton(
                  text: "Register",
                  backGroundBtnColor: isConfirmed && isAllFieldsFilled
                      ? AppColors.btnLoginColor
                      : AppColors.btnLoginColor,
                  onPressed: () {
                    if (isConfirmed && isAllFieldsFilled) {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.login);
                    }
                  },
                ),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

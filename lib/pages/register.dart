///import 'package:cow_students_connection/components/app_otp.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/pages/OTP.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cow_students_connection/components/app_button.dart';
import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/config/app_icon.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  const Register({super.key});
  static String verify = "";
  @override
  _RegisterState createState() => _RegisterState();
}

///
/// Check if a phone number if valid or not.
/// [phoneNumber] The phone number which will be validated.
/// Return true if the phone number is valid. Otherwise, return false.
bool isValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string == null || string.isEmpty) {
    return false;
  }

  // You may need to change this pattern to fit your requirement.
  // I just copied the pattern from here: https://regexr.com/3c53v
  const pattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
  final regExp = RegExp(pattern);

  if (!regExp.hasMatch(string)) {
    return false;
  }
  return true;
}

class _RegisterState extends State<Register> {
  // bool isConfirmed = false;
  // bool isFullnameFilled = false;
  // bool isPasswordFilled = false;
  // bool isPhoneFilled = false;
  TextEditingController countrycode = TextEditingController();
  // var phone = context.read<AppRepo>().getPhone;
  // var password = " ";

  @override
  Widget build(BuildContext context) {
    // bool isAllFieldsFilled =
    //     isFullnameFilled && isPasswordFilled && isPhoneFilled;
    var phone = context.read<AppRepo>().phone;
    var password = context.read<AppRepo>().password;
    ;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context)
              .unfocus(); // Ẩn bàn phím khi người dùng nhấn vào không gian trống
        },
        child: SingleChildScrollView(
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
                  // AppTextField(
                  //   hint: "Fullname",
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "Phone",
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value;
                      context.read<AppRepo>().phone = value;
                      print(
                        "provider phone: ${context.read<AppRepo>().phone}",
                      );
                      print(
                        "Password: ${phone}",
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "Password",
                    onChanged: (value) {
                      password = value;
                      context.read<AppRepo>().password = value;
                      print(
                        "provider Password: ${context.read<AppRepo>().password}",
                      );
                      print(
                        "Password: ${password}",
                      );
                    },
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: true,
                        // value: isConfirmed,
                        onChanged: (bool? newValue) {
                          // if (newValue != null) {
                          //   // Kiểm tra giá trị newValue có null hay không
                          //   setState(() {
                          //     isConfirmed = newValue;
                          //   });
                          // }
                        },
                      ),
                      Text(
                        "Confirm",
                        style:
                            AppText.body1, // Điều chỉnh kiểu chữ theo nhu cầu
                      ),
                    ],
                  ),
                  Spacer(),
                  AppButton(
                    text: "Send OTP",
                    // backGroundBtnColor: isConfirmed && isAllFieldsFilled
                    //     ? AppColors.btnLoginColor
                    //     : AppColors.btnLoginColor,

                    // print("${countrycode.text}"); //null??
                    // print("${phone}");

                    onPressed: () async {
                      if (!isValidPhoneNumber(phone!) || password!.length < 8) {
                        // Show error message for invalid phone number or password length

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please enter a valid phone number and a password of at least 8 characters.',
                            ),
                          ),
                        );
                      } else {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '+84 $phone',
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            Register.verify = verificationId;
                            Navigator.of(context).pushNamed(AppRoutes.otp);
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                      }
                    },

                    // if (isConfirmed && isAllFieldsFilled) {
                    //   Navigator.of(context)
                    //       .pushReplacementNamed(AppRoutes.login);
                    // }
                  ),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

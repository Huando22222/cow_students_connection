///import 'package:cow_students_connection/components/app_otp.dart';
import 'package:cow_students_connection/components/OTP.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  static String verify = "";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // bool isConfirmed = false;
  // bool isFullnameFilled = false;
  // bool isPasswordFilled = false;
  // bool isPhoneFilled = false;
  TextEditingController countrycode = TextEditingController();
  var phone = " ";

  @override
  Widget build(BuildContext context) {
    // bool isAllFieldsFilled =
    //     isFullnameFilled && isPasswordFilled && isPhoneFilled;

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
                  AppTextField(
                    hint: "Fullname",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "Password",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "Phone",
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      phone = value;
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
                    onPressed: () async {
                      print("${countrycode.text}"); //null??
                      print("${phone}");

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        // phoneNumber: '+44 7123 123 456',
                        phoneNumber: '+84 ${phone}',
                        // phoneNumber: '${countrycode.text + phone}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          Register.verify = verificationId;
                          Navigator.of(context).pushNamed(AppRoutes.otp);
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );

                      // if (isConfirmed && isAllFieldsFilled) {
                      //   Navigator.of(context)
                      //       .pushReplacementNamed(AppRoutes.login);
                      // }
                    },
                  ),
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

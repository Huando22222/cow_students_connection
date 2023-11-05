import 'package:cow_students_connection/components/app_button.dart';
import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/config/app_icon.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                AppTextField(hint: "username"),
                SizedBox(
                  height: 20,
                ),
                AppTextField(hint: "password"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "don't have an account",
                      style: AppText.subtitle3.copyWith(
                          // fontSize: 20,
                          ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.register);
                      },
                      child: Text(
                        "Sign up",
                        style: AppText.subtitle1,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                AppButton(
                  text: "Login",
                  backGroundBtnColor: AppColors.btnLoginColor,
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.main);
                  },
                ),
                Spacer(),
                AppButton(
                  text: "Login with google",
                  backGroundBtnColor: AppColors.btnLoginWithGoogleColor,
                  icon: AppIcons.ic_google,
                  onPressed: () {},
                ),
                AppButton(
                  text: "Login with facebook",
                  backGroundBtnColor: AppColors.btnLoginWithFacebookColor,
                  icon: AppIcons.ic_facebook,
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

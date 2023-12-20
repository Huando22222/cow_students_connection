import 'dart:convert';

import 'package:cow_students_connection/api/google_signin_api.dart';
import 'package:cow_students_connection/components/app_button.dart';
import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/config/app_icon.dart';
import 'package:cow_students_connection/data/models/account.dart';
import 'package:cow_students_connection/data/models/room.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/chatmessage.dart';
import 'package:cow_students_connection/pages/facebook_login_page.dart';
import 'package:cow_students_connection/pages/logged_in_page.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:cow_students_connection/util/socket/socket_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var phone;
    var password; //test
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
                    hint: "phone number",
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      context.read<AppRepo>().phone = value;
                      phone = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppTextField(
                    hint: "password",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onChanged: (value) {
                      context.read<AppRepo>().password = value;
                      password = value;
                    },
                  ),
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
                          Navigator.of(context).pushNamed(AppRoutes.register);
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
                    onPressed: () async {
                      print(
                          "${context.read<AppRepo>().phone}---------------------Server recieved ACCOUNT :${context.read<AppRepo>().password}--------------------");
                      final response = await http.post(
                        Uri.parse('${AppConfig.baseUrl}user/login'),
                        body: {
                          'phone': context.read<AppRepo>().phone,
                          'password': context.read<AppRepo>().password,
                        },
                      );

                      if (response.statusCode == 200) {
                        final SocketMethods _socketMethods = SocketMethods();
                        _socketMethods.MessageListener(context);

                        final responseData = jsonDecode(response.body);
                        final accountData =
                            account.fromJson(responseData['account']);
                        context.read<AppRepo>().Account = accountData;
                        if (responseData['room'] != null) {
                          context.read<ChatProvider>().addListRooms(
                                (responseData['room'] as List)
                                    .map((data) => room.fromJson(data))
                                    .toList(),
                              );

                          print(
                              "room: ${context.read<ChatProvider>().rooms[0].roomName}");
                        }
                        print(
                            "Received acc data: ${context.read<AppRepo>().Account!.idAcc}");
                        var userData = responseData['user'];
                        if (userData == null) {
                          print("user data have value null ( object )");
                          Navigator.of(context).pushNamed(AppRoutes.welcome);
                        } else {
                          userData = user.fromJson(responseData['user']);
                          context.read<AppRepo>().User = userData;

                          Navigator.of(context).pushNamed(AppRoutes.main);
                        }
                        //neviagave
                      } else {
                        print(
                            'Lỗi khi gửi thông tin đến máy chủ: ${response.statusCode}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Incorrect phone number or password. Please try again.',
                            ),
                          ),
                        );
                      }

                      // Navigator.of(context).pushNamed(AppRoutes.main);
                      //pushReplacementNamed
                    },
                  ),
                  Spacer(),
                  AppButton(
                    text: "Login with google",
                    backGroundBtnColor: AppColors.btnLoginWithGoogleColor,
                    icon: AppIcons.ic_google,
                    onPressed: () => _loginWithGoogle(context),
                    // onPressed: () {
                    //   signIn;
                    // },
                  ),
                  AppButton(
                    text: "Login with facebook",
                    backGroundBtnColor: AppColors.btnLoginWithFacebookColor,
                    icon: AppIcons.ic_facebook,
                    onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FacebookLoginPage(),
                      ))
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

  Future _loginWithGoogle(BuildContext context) async {
    final user = await GoogleSignInApi.login();

    if (user == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Sign in Falsed")));
      return null;
    } else {
      print("photoURL : ${user.photoUrl}");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoggedInPage(user: user),
      ));
    }
  }

  // Future _loginWithFacebook(BuildContext context) async {
  //   final result = await FacebookAuth.instance.login();

  //   if (result.status == LoginStatus.success) {
  //     _accessToken = result.accessToken;
  //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoggedInPage(user: result.user)); // Chuyển đến trang LoggedInPage với thông tin user.
  //   } else {
  //     print("Login failed: ${result.message}");
  //   }
  // }
}

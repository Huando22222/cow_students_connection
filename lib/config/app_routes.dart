import 'package:cow_students_connection/pages/OTP.dart';
import 'package:cow_students_connection/pages/home.dart';
import 'package:cow_students_connection/pages/login.dart';
import 'package:cow_students_connection/pages/main_page.dart';
import 'package:cow_students_connection/pages/profile.dart';
import 'package:cow_students_connection/pages/register.dart';
import 'package:cow_students_connection/pages/welcome.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
import 'package:provider/provider.dart';

class AppRoutes {
  static final pages = {
    login: (context) => LoginPage(),
    register: (context) => Register(),
    welcome: (context) => WelcomePage(),
    home: (context) => HomePage(),
    // home: (context) => ChangeNotifierProvider(
    //       create: (context) => PostProvider(),
    //       child: HomePage(),
    //     ),

    otp: (context) => OTPPage(),
    //login: (context) => ChangeNotifierProvider(
    //       create: (context) => LoginProvider(),
    //       child: LoginPage(),
    //     ),
    // home: (context) => HomePage(),
    main: (context) => MainPage(),
    // editProfile: (context) => EditProfilePage(),
    // nearby: (context) => NearByPage(),
  };

  static const login = "/";
  static const register = "/register";
  static const welcome = "/welcome";
  static const otp = "/otp";
  static const home = "/home";
  static const main = "/main";
  // static const editProfile = "/edit_profile";
  static const nearby = "/nearby";
  static const ProfilePage = "/ProfilePage";
}

import 'package:cow_students_connection/pages/home.dart';
import 'package:cow_students_connection/pages/login.dart';
import 'package:cow_students_connection/pages/main_page.dart';
import 'package:cow_students_connection/pages/register.dart';

class AppRoutes {
  static final pages = {
    login: (context) => LoginPage(),
    register: (context) => Register(),
    home: (context) => HomePage(),
    register: (context) => Register(),
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
  static const home = "/home";
  static const main = "/main";
  static const editProfile = "/edit_profile";
  static const nearby = "/nearby";
}

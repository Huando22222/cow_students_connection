import 'package:cow_students_connection/pages/home.dart';
import 'package:cow_students_connection/pages/login.dart';
import 'package:cow_students_connection/pages/main_page.dart';

class AppRoutes {
  static final pages = {
    login: (context) => LoginPage(),
    home: (context) => HomePage(),
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
  static const home = "/home";
  static const main = "/main";
  static const editProfile = "/edit_profile";
  static const nearby = "/nearby";
}
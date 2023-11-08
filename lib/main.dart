import 'dart:io';

import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/providers/account_provider.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyC5va3d5Y5-XUVs-6kIpTkyxsqh_nq9TMk",
            appId: "1:62520559372:android:51e74624d0ba90d1f8eb29",
            messagingSenderId: "62520559372",
            projectId: "cow-students-connection-404016",
          ),
        )
      : await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => AppRepo(),
      ),
    ],
    child: MyApp(),
  ));
}

// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Urbanist",
        scaffoldBackgroundColor: AppColors.backGroundApp,
        brightness: Brightness.light,
      ),
      initialRoute: "/",
      routes: AppRoutes.pages,
    );
  }
}
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// void main() {
//   runApp(const MyApp());
// }

// String prettyPrint(Map json) {
//   JsonEncoder encoder = const JsonEncoder.withIndent('  ');
//   String pretty = encoder.convert(json);
//   return pretty;
// }

// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   Map<String, dynamic>? _userData;
//   AccessToken? _accessToken;
//   bool _checking = true;

//   @override
//   void initState() {
//     super.initState();
//     _checkIfIsLogged();
//   }

//   Future<void> _checkIfIsLogged() async {
//     final accessToken = await FacebookAuth.instance.accessToken;
//     setState(() {
//       _checking = false;
//     });
//     print("checking accessssssssssssssssssssssssssssssssssssssssss");
//     if (accessToken != null) {
//       print("checking access accessToken");

//       print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
//       // now you can call to  FacebookAuth.instance.getUserData();
//       final userData = await FacebookAuth.instance.getUserData();
//       // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
//       _accessToken = accessToken;
//       setState(() {
//         _userData = userData;
//       });
//     }
//   }

//   void _printCredentials() {
//     print(
//       prettyPrint(_accessToken!.toJson()),
//     );
//   }

//   Future<void> _login() async {
//     final LoginResult result = await FacebookAuth.instance
//         .login(); // by default we request the email and the public profile
//     print("checking access accessToken");
//     // loginBehavior is only supported for Android devices, for ios it will be ignored
//     // final result = await FacebookAuth.instance.login(  //nap vip mới có thể coi dc nhé dumeno
//     //   permissions: [
//     //     'email',
//     //     'public_profile',
//     //     'user_birthday',
//     //     'user_friends',
//     //     'user_gender',
//     //     'user_link'
//     //   ],
//     //   loginBehavior: LoginBehavior
//     //       .dialogOnly, // (only android) show an authentication dialog instead of redirecting to facebook app
//     // );

//     if (result.status == LoginStatus.success) {
//       _accessToken = result.accessToken;
//       _printCredentials();
//       // get the user data
//       // by default we get the userId, email,name and picture
//       final userData = await FacebookAuth.instance.getUserData();
//       // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
//       _userData = userData;
//     } else {
//       print(result.status);
//       print(result.message);
//     }

//     setState(() {
//       _checking = false;
//     });
//   }

//   Future<void> _logOut() async {
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Facebook Auth Example'),
//         ),
//         body: _checking
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         _userData != null
//                             ? prettyPrint(_userData!)
//                             : "NO LOGGED",
//                       ),
//                       const SizedBox(height: 20),
//                       _accessToken != null
//                           ? Text(
//                               prettyPrint(_accessToken!.toJson()),
//                             )
//                           : Container(),
//                       const SizedBox(height: 20),
//                       CupertinoButton(
//                         color: Colors.blue,
//                         child: Text(
//                           _userData != null ? "LOGOUT" : "LOGIN",
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                         onPressed: _userData != null ? _logOut : _login,
//                       ),
//                       const SizedBox(height: 50),
//                     ],
//                   ),
//                 ),
//               ),
//       ),
//     );
//   }
// }

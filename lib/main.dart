import 'dart:io';

import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
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
      ChangeNotifierProvider(
        create: (context) => ChatProvider(),
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
      onUnknownRoute: (settings) {
        // Trả về một trang hoặc widget tùy thuộc vào nhu cầu của bạn.
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('Page not found! MAIN.dart'),
            ),
          ),
        );
      },
    );
  }
}

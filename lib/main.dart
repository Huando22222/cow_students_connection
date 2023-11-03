import 'package:cow_students_connection/config/app_config.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

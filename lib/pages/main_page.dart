import 'package:cow_students_connection/components/bottom_navigation_item.dart';
/////tao folder chat
import 'package:cow_students_connection/pages/chat/chat_page.dart';
import 'package:cow_students_connection/pages/chat/chat_to_person.dart';

import 'package:cow_students_connection/pages/home.dart';
import 'package:cow_students_connection/pages/location.dart';
import 'package:cow_students_connection/pages/profile.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/providers/post_location_provider.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

enum Menu {
  home,
  message,
  location,
  notification,
  user,
}

class _MainPageState extends State<MainPage> {
  final pages = [
    ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: HomePage(),
    ),

    ChatPage(),
    // ChatToPerson(),

    ChangeNotifierProvider(
      create: (context) => PostLocationProvider(),
      child: Location(),
    ),
    Center(
      child: Text("Notification"),
    ),
    ProfilePage(),
  ];
  Menu currentIndex = Menu.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true, // tranparent background
      body: pages[currentIndex.index],
      // backgroundColor: Colors.transparent,
      bottomNavigationBar: CustomNavigation(
        currentIndex: currentIndex,
        onTap: (value) {
          // if (value == Menu.location) {
          //   showModalBottomSheet(
          //     backgroundColor: Colors.transparent,
          //     context: context,
          //     isScrollControlled: true,
          //     builder: (context) {
          //       return Container();
          //     },
          //   );
          // }
          setState(() {
            currentIndex = value;
          });
        },
      ),
    );
  }
}

class CustomNavigation extends StatelessWidget {
  final Menu currentIndex;
  final ValueChanged<Menu> onTap;
  const CustomNavigation({
    // super.key,
    Key? key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(10),
      // color: Colors.transparent,
      color: Colors.transparent,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: AppColors.navigationBarColor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Row(
          children: [
            Expanded(
              child: BottomNavigationItem(
                  onPressed: () => onTap(Menu.home),
                  icon: "assets/images/ic_home.svg",
                  current: currentIndex,
                  name: Menu.home),
            ),
            Expanded(
              child: BottomNavigationItem(
                  onPressed: () => onTap(Menu.message),
                  icon: "assets/images/ic_message.svg",
                  current: currentIndex,
                  name: Menu.message),
            ),
            Expanded(
              child: BottomNavigationItem(
                  onPressed: () => onTap(Menu.location),
                  icon: "assets/images/ic_location.svg",
                  current: currentIndex,
                  name: Menu.location),
            ),
            Expanded(
              child: BottomNavigationItem(
                  onPressed: () => onTap(Menu.notification),
                  icon: "assets/images/ic_notification.svg",
                  current: currentIndex,
                  name: Menu.notification),
            ),
            Expanded(
              child: BottomNavigationItem(
                  onPressed: () => onTap(Menu.user),
                  icon: "assets/images/ic_user.svg",
                  current: currentIndex,
                  name: Menu.user),
            ),
          ],
        ),
      ),
    );
  }
}

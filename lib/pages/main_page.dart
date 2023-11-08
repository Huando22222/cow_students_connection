import 'package:cow_students_connection/components/bottom_navigation_item.dart';
import 'package:cow_students_connection/model/user.dart';
import 'package:cow_students_connection/pages/profile.dart';
import 'package:cow_students_connection/pages/profile.dart';
import 'package:cow_students_connection/providers/user_provider.dart';
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
    Center(
      child: Text("Home dđ"),
    ),
    Center(
      child: Text("Message"),
    ),
    Center(
      child: Text("Location"),
    ),
    Center(
      child: Text("Notification"),
    ),
    Profile(),
  ];
  Menu currentIndex = Menu.home;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    // Thay đổi thông tin người dùng
    userProvider.setUser(User(
      displayName: 'John Doe',
      email: 'john@example.com',
      id: '123456',
      photoUrl: 'https://example.com/johndoe.jpg',
      serverAuthCode: 'authCode123',
      idToken: 'token123',
      // Các thông tin khác
    ));

    return Scaffold(
      body: pages[currentIndex.index],
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
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 87,
      margin: EdgeInsets.all(10),
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

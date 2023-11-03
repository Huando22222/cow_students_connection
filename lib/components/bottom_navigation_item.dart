import 'package:cow_students_connection/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavigationItem extends StatelessWidget {
  final VoidCallback onPressed;
  final String icon;
  final Menu current;
  final Menu name;
  const BottomNavigationItem(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.current,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(
          current == name ? Colors.white : Colors.black, //.withOpacity(0.3),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}

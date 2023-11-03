import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Color? backGroundBtnColor;
  final String? icon;
  final VoidCallback? onPressed;
  const AppButton({
    super.key,
    required this.text,
    this.backGroundBtnColor,
    this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
          side: BorderSide(color: Colors.black, width: 2),
        ),
        maximumSize: Size(300, 80),
        minimumSize: Size(200, 40),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Row(
              children: [
                SvgPicture.asset(
                  icon!,
                  width: 24, // Đặt chiều rộng mong muốn
                  height: 24,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          Text(
            text,
            style: AppText.subtitle1.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

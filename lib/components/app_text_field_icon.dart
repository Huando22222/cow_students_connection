import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldIcon extends StatelessWidget {
  final String? icon;
  final String? hint;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  const AppTextFieldIcon(
      {super.key, this.icon, this.hint, this.keyboardType, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        decoration: InputDecoration(
          // hintText: hint,
          labelText: hint != null ? hint : "",
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 197, 22, 22),
          ),
          // border: UnderlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(12)),
          // ),
          // focusedBorder: const UnderlineInputBorder(
          //   borderRadius: BorderRadius.all(Radius.circular(10)),
          //   borderSide: BorderSide(color: Colors.transparent),
          // ),
          filled: true,
          fillColor: AppColors.field,
        ),
        keyboardType: keyboardType ?? TextInputType.text,
        onChanged: onChanged,
      ),
    );
  }
}

import 'package:cow_students_connection/styles/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  const AppTextField({super.key, this.hint});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: hint,
          labelStyle: TextStyle(
            color: Color.fromARGB(255, 197, 22, 22),
          ),
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          filled: true,
          fillColor: AppColors.field,
        ),
      ),
    );
  }
}

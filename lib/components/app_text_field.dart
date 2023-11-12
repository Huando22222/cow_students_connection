// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cow_students_connection/styles/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String? hint;
  final double? sizedWidth;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? svgPicture;
  final bool? showLabel;
  final Color? colorLabel;
  final TextEditingController? controller;
  const AppTextField({
    Key? key,
    this.hint,
    this.sizedWidth,
    this.keyboardType,
    this.onChanged,
    this.svgPicture,
    this.showLabel,
    this.colorLabel,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: sizedWidth,
      child: Row(
        children: [
          if (svgPicture != null)
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                svgPicture!,
                width: 50,
                height: 50,
              ),
            ),
          Expanded(
            child: TextField(
              controller: controller ?? null,
              decoration: InputDecoration(
                hintText: hint,
                labelText: showLabel == false ? null : hint,
                labelStyle: TextStyle(
                  color: colorLabel ?? AppColors.labelColor,
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
              keyboardType: keyboardType ?? TextInputType.text,
              onChanged: onChanged ?? null,
            ),
          ),
        ],
      ),
    );
  }
}

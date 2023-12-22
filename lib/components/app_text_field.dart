// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cow_students_connection/styles/app_colors.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final double? sizedWidth;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String? svgPicture;
  final bool? showLabel;
  final Color? colorLabel;
  final TextEditingController? controller;
  final bool? obscureText; // Thêm thuộc tính này

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
    this.obscureText,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _isObscure; // Sử dụng biến này để lưu trạng thái của mật khẩu

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText ??
        false; // Thiết lập trạng thái ban đầu từ thuộc tính của widget
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.sizedWidth,
      child: Row(
        children: [
          if (widget.svgPicture != null)
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: SvgPicture.asset(
                widget.svgPicture!,
                width: 50,
                height: 50,
              ),
            ),
          Expanded(
            child: TextField(
              controller: widget.controller ?? null,
              decoration: InputDecoration(
                hintText: widget.hint,
                labelText: widget.showLabel == false ? null : widget.hint,
                labelStyle: TextStyle(
                  color: widget.colorLabel ?? AppColors.labelColor,
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
                // Sử dụng _isObscure để xác định trạng thái hiện tại của mật khẩu
                suffixIcon: widget.obscureText != null &&
                        widget.obscureText == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure; // Đảo ngược trạng thái
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                      )
                    : null,
              ),
              keyboardType: widget.keyboardType ?? TextInputType.text,
              onChanged: widget.onChanged ?? null,
              // Sử dụng _isObscure để ẩn/hiện mật khẩu
              obscureText: _isObscure,
            ),
          ),
        ],
      ),
    );
  }
}

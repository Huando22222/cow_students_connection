import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';

class ChatOtherItem extends StatelessWidget {
  final String chat;
  const ChatOtherItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 93, 163, 206),
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Text(chat, style: AppText.body1),
        ),
      ),
    );
  }
}

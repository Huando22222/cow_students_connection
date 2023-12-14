import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';

class ChatMeItem extends StatelessWidget {
  final String chat;
  const ChatMeItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 225, 221, 208),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
          child: Text(chat, style: AppText.body1),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:cow_students_connection/styles/app_text.dart';

class ChatOtherItem extends StatelessWidget {
  final String chat;
  final bool samePerson;
  const ChatOtherItem({
    Key? key,
    required this.chat,
    required this.samePerson,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 93, 163, 206),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
            bottomLeft: Radius.circular(5),
            topLeft: Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Text(chat, style: AppText.message),
        ),
      ),
    );
  }
}

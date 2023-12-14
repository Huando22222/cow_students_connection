import 'package:flutter/material.dart';

class ChatMeItem extends StatelessWidget {
  final String chat;
  const ChatMeItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        decoration:
            BoxDecoration(color: const Color.fromARGB(255, 225, 221, 208)),
        child: Text(chat),
      ),
    );
  }
}

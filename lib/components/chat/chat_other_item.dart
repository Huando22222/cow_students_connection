import 'package:flutter/material.dart';

class ChatOtherItem extends StatelessWidget {
  final String chat;
  const ChatOtherItem({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 114, 162, 84)),
        child: Text(chat),
      ),
    );
  }
}

import 'package:cow_students_connection/components/chat/chat_me_item.dart';
import 'package:cow_students_connection/components/chat/chat_other_item.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppChat extends StatelessWidget {
  final List<message>? messages;
  final String room;
  const AppChat({
    super.key,
    this.messages,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    bool samePerson = true;
    return ListView.separated(
      itemBuilder: (context, index) {
        if (room == messages![index].room) {
          if (messages![index].sender.id == context.read<AppRepo>().User!.id) {
            samePerson = true;
            return ChatMeItem(chat: messages![index].content);
          } else {
            samePerson = false;
            return ChatOtherItem(chat: messages![index].content);
          }
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return samePerson ? SizedBox(height: 2) : SizedBox(height: 10);
      },
      itemCount: messages!.length,
    );
  }
}

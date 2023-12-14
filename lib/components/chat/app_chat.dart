import 'package:cow_students_connection/components/chat/chat_me_item.dart';
import 'package:cow_students_connection/components/chat/chat_other_item.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppChat extends StatelessWidget {
  final List<message>? messages;
  const AppChat({super.key, this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (messages![index].sender.id == context.read<AppRepo>().User!.id) {
          return ChatMeItem(chat: messages![index].content);
        } else {
          return InkWell(
            onTap: () {
              print(
                  "${context.read<AppRepo>().User!.id} - ${messages![index].sender.id}");
            },
            child: ChatOtherItem(chat: messages![index].content),
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 20,
        );
      },
      itemCount: messages!.length,
    );
  }
}

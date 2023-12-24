import 'package:cow_students_connection/components/app_avatar.dart';
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
    bool isContinuous = false;
    return ListView.separated(
      itemBuilder: (context, index) {
        print("app_chat print chats: ${messages!.length}");
        if (room == messages![index].room) {
          print("app_chat print room: ${messages![index].room}");
          // if (index + 1 < messages!.length &&
          //     messages![index + 1].sender.id == messages![index].sender.id) {
          //   isContinuous = true;
          // } else {
          //   isContinuous = false;
          // }
          //no need anymore -> should bring it out ChatToPerson
          if (messages![index].sender.id == context.read<AppRepo>().User!.id) {
            return ChatMeItem(chat: messages![index].content);
          } else {
            return Column(
              children: [
                Row(
                  children: [
                    // if (!isContinuous)
                    //   AppAvatar(
                    //     pathImage: messages![index].sender.avatar,
                    //     size: 40,
                    //   )
                    // else
                    //   SizedBox(
                    //     width: 40,
                    //   ),
                    ChatOtherItem(
                      chat: messages![index].content,
                      samePerson: isContinuous,
                    ),
                  ],
                ),
                // if (isContinuous == false)
                SizedBox(
                  height: 20,
                )
              ],
            );
          }
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        // return ortherMSG ? SizedBox(height: 2) : SizedBox(height: 10);
        return SizedBox(
          height: 2,
        );
      },
      itemCount: messages!.length,
    );
  }
}

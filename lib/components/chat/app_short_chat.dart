import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/pages/chat/chat_to_person.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/styles/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppShortChat extends StatelessWidget {
  final message msg;
  const AppShortChat({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    String latestSender = "";
    if (msg.sender.id == context.read<AppRepo>().User!.id) {
      latestSender = "you";
    } else {
      latestSender = "${msg.sender.lastName}";
    }

    String chatTo = "";
    var matchingRoom = context.read<ChatProvider>().rooms.firstWhere(
          (room) => room.id == msg.room,
        );

    var otherUser = matchingRoom.users.firstWhere(
      (user) => user.id != context.read<AppRepo>().User!.id,
    );
    chatTo = otherUser.firstName! + " " + otherUser.lastName!;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatToPerson(
              // titleAppBar: chatTo,
              room: msg.room,
              userInfo: otherUser,
            ),
          ),
        );
      },
      child: Container(
        // color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatar(
                pathImage: otherUser.avatar,
                size: 70,
              ), //context.read<AppRepo>().User!.avatar//test//otherUser.avatar
              SizedBox(
                width: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatTo, style: AppText.message),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          "${latestSender}: ${msg.content}",
                          style: AppText.subMessage,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

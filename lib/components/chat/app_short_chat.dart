import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/pages/chat/chat_to_person.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
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
        child: Row(
          children: [
            AppAvatar(
              pathImage: context.read<AppRepo>().User!.avatar,
              size: 70,
            ), //context.read<AppRepo>().User!.avatar//test//otherUser.avatar
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Text(chatTo),
                Text("${latestSender}: ${msg.content}"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

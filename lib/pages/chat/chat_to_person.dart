// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cow_students_connection/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/components/chat/app_chat.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/util/socket/socket_methods.dart';

class ChatToPerson extends StatelessWidget {
  final String room;
  final user userInfo;
  const ChatToPerson({
    Key? key,
    required this.room,
    required this.userInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textFieldController = TextEditingController();
    final SocketMethods _socketMethods = SocketMethods();
    message? Message;
    String content = "";

    return Scaffold(
      appBar: AppBar(title: Text("${userInfo.firstName} ${userInfo.lastName}")),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: room == "unRoom"
                  ? Text(
                      "you and ${userInfo.lastName} don't have a conversation before  ")
                  : Consumer<ChatProvider>(
                      builder: (context, value, child) {
                        return AppChat(
                          room: room,
                          messages: value.chats,
                        );
                      },
                    ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _textFieldController,
                    onChanged: (value) {
                      content = value;
                      print(content);
                    },
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    // content = "";
                    // print("sent: ${Message!.content}");//asdasdasdas
                    Message = message(
                      content: content,
                      sender: context.read<AppRepo>().User!,
                      room: room,
                    );

                    if (room == "unRoom") {
                      List<String> member = [];
                      member.add(userInfo.id!);
                      member.add(context.read<AppRepo>().User!.id!);
                      _socketMethods.createRoom(member, Message!);
                      print("room ${room} : - ChatToPerson - create room");
                      /////////gui ca tn nua!!!!!!!!!!!!!!!!!!!!!!!!
                    } else {
                      print(
                          "room ${room} : - ChatToPerson - sent content: ${content}");
                      _socketMethods.Send(Message!);
                    }
                  },
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

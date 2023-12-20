import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/components/chat/app_chat.dart';
import 'package:cow_students_connection/components/chat/chat_me_item.dart';
import 'package:cow_students_connection/config/app_icon.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/util/socket/socket_methods.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SocketMethods _socketMethods = SocketMethods();
    // _socketMethods.MessageListener(context);
    message? Message;
    String content = "";

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, value, child) {
                  return AppChat(
                    messages: value.chats,
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
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
                    Message = message(
                      content: content,
                      sender: context.read<AppRepo>().User!,
                      room: "room1",
                    );

                    print("sent: ${Message!.content}");

                    _socketMethods.Send(Message!);

                    // _socketMethods.Send(context.read<AppRepo>().User!);
                    // _socketMethods.Send();
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

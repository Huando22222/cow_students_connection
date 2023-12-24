import 'package:cow_students_connection/components/chat/app_short_chat.dart';
import 'package:cow_students_connection/config/app_routes.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/pages/chat/chat_to_person.dart';
import 'package:cow_students_connection/pages/home.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, value, child) {
                  if (value.chats.isEmpty) {
                    return Center(
                      child: InkWell(
                        onTap: () {
                          // Navigator.of(context).pushNamed(AppRoutes.home); //????????????????????????
                        },
                        child: Text("Bat dau giao tiep di tk lonnn"),
                      ),
                    );
                  } else {
                    List<String> listRooms = [];
                    List<message> listMessages = [];
                    for (var index = value.chats.length - 1;
                        index >= 0;
                        index--) {
                      if (!listRooms.contains(value.chats[index].room)) {
                        //////////// nên đưa ra ngoàI ListView rồI thay thế ListView = cái j đó khác
                        listRooms.add(value.chats[index].room);
                        listMessages.add(value.chats[index]);
                      }
                    }
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        // if(value..chats[index].room=)
                        return AppShortChat(msg: listMessages[index]);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: listRooms.length,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

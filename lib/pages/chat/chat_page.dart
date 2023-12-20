import 'package:cow_students_connection/components/chat/app_short_chat.dart';
import 'package:cow_students_connection/config/app_routes.dart';
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
                  List<String> listRooms = [];
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
                    return ListView.separated(
                      itemBuilder: (context, index) {
                        int reversedIndex = value.chats.length - 1 - index;
                        String room = value.chats[reversedIndex].room;
                        if (!listRooms.contains(room)) {
                          listRooms.add(room);
                          print("room chat_page: ${room}");
                          return AppShortChat(msg: value.chats[reversedIndex]);
                        }
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 5,
                        );
                      },
                      itemCount: listRooms.length + 1,
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

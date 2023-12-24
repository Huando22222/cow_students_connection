// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cow_students_connection/components/app_avatar.dart';
import 'package:cow_students_connection/components/chat/chat_me_item.dart';
import 'package:cow_students_connection/components/chat/chat_other_item.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import 'package:cow_students_connection/components/app_text_field.dart';
import 'package:cow_students_connection/components/chat/app_chat.dart';
import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:cow_students_connection/util/socket/socket_methods.dart';

class ChatToPerson extends StatefulWidget {
  String room;
  final user userInfo;
  ChatToPerson({
    Key? key,
    required this.room,
    required this.userInfo,
  }) : super(key: key);

  @override
  State<ChatToPerson> createState() => _ChatToPersonState();
}

class _ChatToPersonState extends State<ChatToPerson> {
  String abc = "";

  void initState() {
    abc = widget.room;
    super.initState();
  }

  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    final TextEditingController _textFieldController = TextEditingController();
    final SocketMethods _socketMethods = SocketMethods();
    message? Message;
    String content = "";

    return Scaffold(
      appBar: AppBar(
          title:
              Text("${widget.userInfo.firstName} ${widget.userInfo.lastName}")),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context)
                .unfocus(); // Ẩn bàn phím khi người dùng nhấn vào không gian trống
          },
          child: Column(
            children: [
              Expanded(
                child: widget.room == "unRoom"
                    ? Center(
                        child: Text(
                            "you and ${widget.userInfo.lastName} don't have a conversation before  "),
                      )
                    : Consumer<ChatProvider>(
                        builder: (context, value, child) {
                          List<message> chatList = [];
                          for (var item in value.chats) {
                            print(item.room);
                            if (item.room == widget.room) {
                              chatList.add(item);
                              // print("print: ${item.sender.id} - ${item.content}");
                            }
                          }
                          print(chatList);
                          // return AppChat(
                          //   room: room,
                          //   messages: value.chats,
                          // );
                          ////////////////////////??
                          bool isContinuous = false;
                          return ListView.separated(
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              // print(
                              //     "app_chat print chats: ${chatList.length} - ${index}");
                              // print(
                              //     "room - chats.room: ${chatList[index].room} - ${room}");
                              if (widget.room == chatList[index].room) {
                                if (index + 1 < chatList.length &&
                                    chatList[index + 1].sender.id ==
                                        chatList[index].sender.id) {
                                  isContinuous = true;
                                } else {
                                  isContinuous = false;
                                }
                                //no need anymore -> should bring it out ChatToPerson
                                if (chatList[index].sender.id ==
                                    context.read<AppRepo>().User!.id) {
                                  return ChatMeItem(
                                      chat: chatList[index].content);
                                } else {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          if (!isContinuous)
                                            AppAvatar(
                                              pathImage: value
                                                  .chats[index].sender.avatar,
                                              size: 40,
                                            )
                                          else
                                            SizedBox(
                                              width: 40,
                                            ),
                                          ChatOtherItem(
                                            chat: chatList[index].content,
                                            samePerson: isContinuous,
                                          ),
                                        ],
                                      ),
                                      if (isContinuous == false)
                                        SizedBox(
                                          height: 20,
                                        )
                                    ],
                                  );
                                }
                              }
                              return null;
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              // return ortherMSG ? SizedBox(height: 2) : SizedBox(height: 10);
                              return SizedBox(
                                height: 2,
                              );
                            },
                            itemCount: chatList.length,
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
                        room: widget.room,
                      );

                      if (widget.room == "unRoom") {
                        List<String> member = [];
                        member.add(widget.userInfo.id!);
                        member.add(context.read<AppRepo>().User!.id!);
                        _socketMethods.createRoom(member, Message!);
                        abc = context.read<ChatProvider>().rooms.last.id;
                        setState(() {});
                        print(
                            "room ${widget.room} : - ChatToPerson - create room");
                        /////////gui ca tn nua!!!!!!!!!!!!!!!!!!!!!!!!
                      } else {
                        print(
                            "room ${widget.room} : - ChatToPerson - sent content: ${content}");
                        _socketMethods.Send(Message!);
                      }

                      _textFieldController.setText("");
                      content = "";
                      _scrollController.animateTo(
                        _scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    child: Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/data/models/room.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/providers/app_repo.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cow_students_connection/util/socket/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;

  MessageListener(BuildContext context) {
    print("run MessageListener");
    _socketClient.onConnect((data) {
      // List<room> rooms = context.read<ChatProvider>().rooms;
      print("Socket connected: ${_socketClient.id}");
      joinRoom(context.read<AppRepo>().User!.id!);
      // for (var room in rooms) {
      //   joinRoom(room.id);
      // }
    });

    _socketClient.onDisconnect((data) {
      print("Socket disconnected");
    });

    _socketClient.on("add-room", (data) {
      try {
        room recievedRoom = room.fromJson(data);
        print("created room from socket: ${recievedRoom.id}"); // huan sua sau
        context.read<ChatProvider>().addRoom(recievedRoom);
        // joinRoom(recievedRoom.id);
        print("successfully added room & joined ${recievedRoom.id}");
      } catch (e) {
        print("Error in add-room: $e");
      }
    });

    _socketClient.on("recieve", (newMessage) {
      print("On receive message: ");
      message receivedMessage = message.fromJson(newMessage);
      try {
        print("data recieve exists ${receivedMessage} ");
        context.read<ChatProvider>().addMessage(receivedMessage);
      } catch (error) {
        print("Error in recieve listener: $error");
      }
    });

    _socketClient.on("server-message", (data) {
      print("server-message data exists ${data}");
      try {
        if ((data as List).isNotEmpty) {
          List<message> msg =
              (data).map((msg) => message.fromJson(msg)).toList();
          print("server-message exists ${msg.length}");
          context.read<ChatProvider>().addListMessages(msg);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${context.read<ChatProvider>().chats.length} - ${msg[0].content}"),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (error) {
        print("Error in serverMessage listener: $error");
      }
    });
  }

  createRoom(List<String> member, message Messages) {
    print("create Room!!!!!!!!!!!!!!!!!!!!!");
    for (var item in member) {
      print("userID: " + item);
    }

    String msg = json.encode(Messages.toJson());
    _socketClient.emit(
      "create-room",
      // {member, msg},
      {
        "member": member,
        "msg": msg,
      },
    );
  }

  joinRoom(String roomName) {
    _socketClient.emit('join-room', roomName);
    print("joined room: ${roomName}");
  }

  Send(message Messages) {
    String jsonString = json.encode(Messages.toJson());
    _socketClient.emit('send-to', jsonString);
  }
}

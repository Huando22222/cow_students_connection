import 'dart:convert';

import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/data/models/room.dart';
import 'package:cow_students_connection/data/models/user.dart';
import 'package:cow_students_connection/providers/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cow_students_connection/util/socket/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:flutter/material.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance.socket!;
  int count = 0;

  MessageListener(BuildContext context) {
    print("run MessageListener");
    _socketClient.onConnect((data) {
      List<room> rooms = context.read<ChatProvider>().rooms;
      print("Socket connected: ${_socketClient.id}");
      // joinRoom("657ef0d7baf32fe21da8b42b");
      for (var room in rooms) {
        joinRoom(room.id);
      }
    });

    _socketClient.onDisconnect((data) {
      print("Socket disconnected");
    });

    _socketClient.on("add-room", (data) {
      print("run into add-room");
      try {
        print("add-room received data: ");
        room recievedRoom = room.fromJson(data);
        print("created room from socket: ${recievedRoom}"); // huan sua sau
        context.read<ChatProvider>().addRoom(recievedRoom);
      } catch (e) {
        print("Error in add-room: $e");
      }
    });

    _socketClient.on("recieve", (data) {
      count++;
      message receivedMessage = message.fromJson(data);
      try {
        print("data exists ${receivedMessage.sender.id} ${count}");
        context.read<ChatProvider>().addMessage(receivedMessage);
      } catch (error) {
        print("Error in recieve listener: $error");
      }
    });

    _socketClient.on("server-message", (data) {
      print("serverMessage data exists ${data}");
      try {
        List<message> msg =
            (data as List).map((msg) => message.fromJson(msg)).toList();
        print("serverMessage exists ${msg.length}");
        context.read<ChatProvider>().addListMessages(msg);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${context.read<ChatProvider>().chats.length} - ${msg[0].content}"),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (error) {
        print("Error in serverMessage listener: $error");
      }
    });
  }

  createRoom(List<String> member) {
    print("create Room!!!!!!!!!!!!!!!!!!!!!");
    // for (var item in member) {
    //   print("userID: " + item);
    // }
    _socketClient.emit(
      "create-room",
      {member},
    );
  }

  joinRoom(String roomName) {
    _socketClient.emit('join-room', roomName);
    print("joined room: ${roomName}");
  }

  // Send(String content, user sender, String room) {
  //   String jsonString = json.encode({
  //     'content': content,
  //     'sender': sender,
  //     // 'room': room,
  //   });

  //   _socketClient.emit('send-to', {jsonString, room});
  // }

  // Send(message Messages) {
  //   String jsonString = json.encode(Messages.toJson());
  //   String room = "test hard codce room";
  //   _socketClient.emit('send-to', {jsonString, room});
  // }

  Send(message Messages) {
    String jsonString = json.encode(Messages.toJson());
    _socketClient.emit('send-to', jsonString);
  }
}

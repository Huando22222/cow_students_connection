import 'dart:convert';

import 'package:cow_students_connection/data/models/message.dart';
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
      print("Socket connected: ${_socketClient.id}");
      joinRoom("room1");
    });

    _socketClient.onDisconnect((data) {
      print("Socket disconnected");
    });

    _socketClient.on("recieve", (data) {
      print("run even recieve");
      count++;
      message receivedMessage = message.fromJson(data);
      try {
        print("data exists ${receivedMessage.sender.id} ${count}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                "${receivedMessage.sender.id} - ${receivedMessage.content}"),
            duration: Duration(seconds: 2),
          ),
        );
        context.read<ChatProvider>().addMessage(receivedMessage);
      } catch (error) {
        print("Error in recieve listener: $error");
      }
    });
  }

  void joinRoom(String roomName) {
    _socketClient.emit('join-room', roomName);
    print("joined room: ${roomName}");
  }

  Send(message Messages) {
    print("run emit send");
    String jsonString = json.encode(Messages.toJson());
    // _socketClient.emit('send-to', jsonString);
    _socketClient.emit('send-to', jsonString);
  }
}

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2),
    ),
  );
}

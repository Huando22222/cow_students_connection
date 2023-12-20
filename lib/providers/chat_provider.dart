import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/data/models/room.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<message> chats = [];
  List<room> rooms = [];

  void addMessage(message message) {
    chats.add(message);
    // chats.forEach((element) {
    //   print(element.content);
    // });
    print("chat length: ${chats.length}");
    notifyListeners();
  }

  void addListMessages(List<message> messages) {
    chats.clear();
    chats.addAll(messages);
    print("chat length: ${chats.length}");
    notifyListeners();
  }

  void addRoom(room room) {
    rooms.add(room);
    // chats.forEach((element) {
    //   print(element.content);
    // });
    print("room length: ${rooms.length}");
    notifyListeners();
  }
}

import 'package:cow_students_connection/data/models/message.dart';
import 'package:cow_students_connection/data/models/room.dart';
import 'package:cow_students_connection/util/socket/socket_methods.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  List<message> chats = [];
  List<room> rooms = [];
  final SocketMethods _socketMethods = SocketMethods();

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
    print("chats length: ${chats.length}");
    notifyListeners();
  }

  void addRoom(room room) {
    rooms.add(room);
    _socketMethods.joinRoom(room.id);
    // chats.forEach((element) {
    //   print(element.content);
    // });
    print("room length: ${rooms.length}");
    notifyListeners();
  }

  void addListRooms(List<room> room) {
    // rooms.clear();
    rooms.addAll(room);
    room.forEach((element) {
      // print(element.content);
      _socketMethods.joinRoom(element.id);
    });
    print("rooms length: ${rooms.length}");
    notifyListeners();
  }
}

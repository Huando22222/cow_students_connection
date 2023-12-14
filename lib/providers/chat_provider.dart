import 'package:cow_students_connection/data/models/message.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  // List<String> chats = [];
  List<message> chats = [];

  void addMessage(message message) {
    chats.add(message);
    // Thông báo cho người nghe rằng dữ liệu đã thay đổi
    // chats.forEach((element) {
    //   print(element);
    // });
    print(chats.length);
    notifyListeners();
  }
}



// import 'package:cow_students_connection/config/app_config.dart';
// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as io;

// class ChatProvider extends ChangeNotifier {
//   io.Socket? _socket;
//   List<String> chats = [
//     "hardcode testing1",
//     "hardcode testing2",
//     "hardcode testing3"
//   ];

//   connectSocket() {
//     try {
//       print("Connecting to Socket.IO server...");
//       _socket = io.io(AppConfig.baseWs, <String, dynamic>{
//         'transports': ['websocket'],
//         'autoConnect': false,
//       });

//       // Lắng nghe sự kiện từ máy chủ
//       _socket?.on('join-room-emit', (data) {
//         print('Received event from server: $data');
//         // Xử lý dữ liệu từ server ở đây
//         chats.add("join-room");
//         notifyListeners();
//       });

//       // Kết nối đến máy chủ
//       _socket?.connect();
//       print("Connected to Socket.IO server!");
//     } catch (e) {
//       print("Error connecting to Socket.IO server: $e");
//     }
//   }

//   sendMessage(String message) {
//     // Gửi sự kiện đến máy chủ
//     _socket?.emit('send-message', message);
//   }
// }

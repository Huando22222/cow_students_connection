import 'package:cow_students_connection/data/models/user.dart';

class message {
  final String content;
  final user sender;
  final String room;

  message({
    required this.content,
    required this.sender,
    required this.room,
  });

  factory message.fromJson(Map<String, dynamic> json) => message(
        content: json["content"],
        sender: user.fromJson(json["sender"]),
        room: json["room"],
      );

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'sender': sender.toJson(),
      'room': room,
    };
  }
}

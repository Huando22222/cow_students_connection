import 'package:cow_students_connection/data/models/user.dart';

/////////////// k can room ?? de server lo viec room
class room {
  final String id;
  final String roomName;
  final List<user> users;

  room({
    required this.id,
    required this.roomName,
    required this.users,
  });

  factory room.fromJson(Map<String, dynamic> json) {
    return room(
      id: json['_id'],
      roomName: json['roomName'],
      users: List.from(
          (json['users'] as List).map((userJson) => user.fromJson(userJson))),
    );
  }
}

import 'package:cow_students_connection/data/models/user.dart';

class post {
  // final String id;//k can vi server se tu generate
  final String? id;
  final user? owner;
  final String? message;
  final String? images;
  final String? likes;
  final String? createdAt;

  post(
    this.id,
    this.owner,
    this.message,
    this.images,
    this.likes,
    this.createdAt,
  );

  factory post.fromJson(Map<String, dynamic> json) => post(
      json['_id'],
      json['owner'] == null ? null : user.fromJson(json["owner"]),
      json['message'],
      json['images'],
      json['likes'],
      json['createdAt']);
}

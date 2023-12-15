import 'package:cow_students_connection/data/models/user.dart';

class Coordinates {
  final double latitude;
  final double longitude;

  Coordinates.LatLng(this.latitude, this.longitude);

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates.LatLng(json['latitude'], json['longitude']);
  }
}

class postLocation {
  final String? id;
  final user? owner;
  final String? message;
  final Coordinates? location; // Sử dụng lớp Coordinates để đại diện cho vị trí

  postLocation(
    this.id,
    this.owner,
    this.message,
    this.location,
  );

  factory postLocation.fromJson(Map<String, dynamic> json) => postLocation(
        json['_id'],
        json['owner'] == null ? null : user.fromJson(json["owner"]),
        json['message'],
        json['location'] == null
            ? null
            : Coordinates.fromJson(json['location']),
      );
}

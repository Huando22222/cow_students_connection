class user {
  final String? id;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDay;
  final String? gender;
  final String? avatar;
  final String? phone;
  final List<user>? friends;
  final List<String>? rooms;
  final String idAcc;

  user({
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDay,
    this.avatar,
    this.phone,
    this.friends,
    this.rooms,
    required this.idAcc,
  });

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      birthDay:
          json['birthDay'] != null ? DateTime.parse(json['birthDay']) : null,
      avatar: json['avatar'],
      phone: json['phone'],
      friends: json['friends'] != null
          ? List<user>.from((json['friends'] as List)
              .map((userJson) => user.fromJson(userJson)))
          : null,
      rooms: json['rooms'] != null ? List<String>.from(json['rooms']) : null,
      idAcc: json['idAcc'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'birthDay': birthDay?.toIso8601String(),
      'avatar': avatar,
      'phone': phone,
      'friends': friends?.map((user) => user.toJson()).toList(),
      'rooms': rooms,
      'idAcc': idAcc,
    };
  }
}

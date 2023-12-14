class user {
  final String? id;
  final String? firstName;
  final String? lastName;
  final DateTime? birthDay;
  final String? gender;
  final String? avatar;
  final String? phone;
  final String idAcc;

  user(
    this.id,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthDay,
    this.avatar,
    this.phone,
    this.idAcc,
  );

  factory user.fromJson(Map<String, dynamic> json) {
    return user(
      json['_id'],
      json['firstName'],
      json['lastName'],
      json['gender'], // Có thể cần xử lý tùy thuộc vào dữ liệu thực tế
      json['birthDay'] != null ? DateTime.parse(json['birthDay']) : null,
      // json['birthDay'] != null && json['birthDay'] is String
      //     ? DateTime.parse(json['birthDay'])
      //     : json['birthDay'],
      json['avatar'],
      json['phone'],
      json['idAcc'],
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
      'idAcc': idAcc,
    };
  }
}

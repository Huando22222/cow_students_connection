// ignore_for_file: public_member_api_docs, sort_constructors_first
class user {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? birthDay;
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

  factory user.fromJson(Map<String, dynamic> json) => user(
        json['_id'],
        json['firstName'],
        json['lastName'],
        json['birthDay'],
        json['gender'],
        json['avatar'],
        json['phone'],
        json['idAcc'],
      );
}

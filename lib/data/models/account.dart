class account {
  final String idAcc; //k can vi server se tu generate
  final String? phone;
  final String? password;
  final String? fullname;
  final String? email;
  final String? id;
  final String? image;

  account(
    this.idAcc,
    this.phone,
    this.password,
    this.fullname,
    this.email,
    this.id,
    this.image,
  );
  factory account.fromJson(Map<String, dynamic> json) => account(
        json['_id'],
        json['phone'],
        json['password'],
        json['fullname'],
        json['email'],
        json['id'],
        json['image'],
      );
}

class account {
  // final String id;//k can vi server se tu generate
  final String? phone;
  final String? password;
  final String? fullname;
  final String? email;
  final String? id;
  final String? image;

  account(
    this.phone,
    this.password,
    this.fullname,
    this.email,
    this.id,
    this.image,
  );
  factory account.fromJson(Map<String, dynamic> json) => account(
      json['phone'],
      json['password'],
      json['fullname'],
      json['email'],
      json['id'],
      json['image']);
}

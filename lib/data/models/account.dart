class account {
  // final String id;//k can vi server se tu generate
  final String? phone;
  final String? password;
  final String? gfullname;
  final String? gemail;
  final String? gid;
  final String? gimage;

  account(
    this.phone,
    this.password,
    this.gfullname,
    this.gemail,
    this.gid,
    this.gimage,
  );
  factory account.fromJson(Map<String, dynamic> json) => account(
      json['phone'],
      json['password'],
      json['gfullname'],
      json['gemail'],
      json['gid'],
      json['gimage']);
}

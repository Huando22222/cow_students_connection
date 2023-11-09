class account {
  // final String id;//k can vi server se tu generate
  final String? id;
  final String? ownerId;
  final String? message;
  final String? images;
  final String? likes;
  final String? createdAt;

  account(
    this.id,
    this.ownerId,
    this.message,
    this.images,
    this.likes,
    this.createdAt,
  );

  factory account.fromJson(Map<String, dynamic> json) => account(
      json['_id'],
      json['ownerId'],
      json['message'],
      json['images'],
      json['likes'],
      json['createdAt']);
}

class post {
  // final String id;//k can vi server se tu generate
  final String? id;
  final String? ownerId;
  final String? message;
  final String? images;
  final String? likes;
  final String? createdAt;

  post(
    this.id,
    this.ownerId,
    this.message,
    this.images,
    this.likes,
    this.createdAt,
  );

  factory post.fromJson(Map<String, dynamic> json) => post(
      json['_id'],
      json['ownerId'],
      json['message'],
      json['images'],
      json['likes'],
      json['createdAt']);
}

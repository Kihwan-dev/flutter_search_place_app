// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  String id;
  String content;
  double mapX;
  double mapY;
  DateTime createdAt;

  Review({
    required this.id,
    required this.content,
    required this.mapX,
    required this.mapY,
    required this.createdAt,
  });

  // 1. fromJson 네임드 새성자 만들기
  Review.fromJson(Map<String, dynamic> map)
      : this(
          id: map["id"],
          content: map["content"],
          mapX: map["mapX"],
          mapY: map["mapY"],
          createdAt: DateTime.parse(map["createdAt"]),
        );

  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "mapX": mapX,
      "mapY": mapY,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}

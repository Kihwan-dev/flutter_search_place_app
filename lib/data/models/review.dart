// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  String id;
  String content;
  String mapx;
  String mapy;
  DateTime createdAt;

  Review({
    required this.id,
    required this.content,
    required this.mapx,
    required this.mapy,
    required this.createdAt,
  });

  // 1. fromJson 네임드 새성자 만들기
  Review.fromJson(Map<String, dynamic> map)
      : this(
          id: map["id"],
          content: map["content"],
          mapx: map["mapx"],
          mapy: map["mapy"],
          createdAt: DateTime.parse(map["createdAt"]),
        );

  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "content": content,
      "mapx": mapx,
      "mapy": mapy,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}

// {
//   "title": "<b>구의</b>2동주민센터임시청사",
//   "link": "",
//   "category": "공공,사회기관>행정복지센터",
//   "description": "",
//   "telephone": "",
//   "address": "서울특별시 광진구 구의동 63-6",
//   "roadAddress": "서울특별시 광진구 천호대로136길 55",
//   "mapx": "1270899608",
//   "mapy": "375471504"
// },

class Place {
  String title;
  String category;
  String roadAddress;
  String mapx;
  String mapy;

  Place({
    required this.title,
    required this.category,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  double parseCoord(String value) {
    return int.parse(value) / 1e7;
  }

  // 1. fromJson 네임드 생성자 만들기
  Place.fromJson(Map<String, dynamic> map)
      : this(
          title: map["title"],
          category: map["category"],
          roadAddress: map["roadAddress"],
          mapx: map["mapx"],
          mapy: map["mapy"],
        );

  // 2. toJson 메서드 만들기
  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "category": category,
      "roadAddress": roadAddress,
      "mapx": mapx,
      "mapy": mapy,
    };
  }
}

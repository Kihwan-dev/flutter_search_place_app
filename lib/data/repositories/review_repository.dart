import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_search_place_app/data/models/review.dart';

class ReviewRepository {
  Future<List<Review>> getReivewsByAddress({
    required double mapX,
    required double mapY,
  }) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection("reviews");
      // 3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;

      return docs
          .map(
            (doc) {
              final map = doc.data();
              final newMap = {
                "id": doc.id,
                ...map,
              };
              return Review.fromJson(map);
            },
          )
          .where((review) => review.mapX == mapX && review.mapY == mapY)
          .toList();
    } catch (e) {
      print("오류 발생");
      print(e);
      return [];
    }
  }

  Future<bool> addReview({
    required String content,
    required double mapX,
    required double mapY,
  }) async {
    // 1. 파이어스토어 인스턴스 가지고 오기
    final firestore = FirebaseFirestore.instance;
    // 2. 컬렉션 참조 만들기
    final collectionRef = firestore.collection("reviews");
    // 3. 문서 참조 만들기
    final docRef = collectionRef.doc();
    // 4. 값 쓰기
    await docRef.set({
      "content": content,
      "mapX": mapX,
      "mapY": mapY,
      "createdAt": DateTime.now().toIso8601String(),
    });
    return false;
  }
}

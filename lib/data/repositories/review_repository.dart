import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_search_place_app/data/models/review.dart';

class ReviewRepository {
  Future<List<Review>> getReivewsByAddress(String address) async {
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
          .where((review) => review.address == address)
          .toList();
    } catch (e) {
      print("오류 발생");
      print(e);
      return [];
    }
  }
}

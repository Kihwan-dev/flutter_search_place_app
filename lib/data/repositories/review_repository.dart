import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_search_place_app/data/models/review.dart';

class ReviewRepository {
  Future<List<Review>> getReivewsByCoordinate({
    required String mapx,
    required String mapy,
  }) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection("reviews");
      // 3. 값 불러오기
      final result = await collectionRef.get();
      final docs = result.docs;
      // print("docs.length : ${docs.length}");

      return docs
          .map((doc) {
            final map = doc.data();
            // print(map);
            final newMap = {
              "id": doc.id,
              ...map,
            };
            return Review.fromJson(newMap);
          })
          .where((review) => review.mapx == mapx && review.mapy == mapy)
          .toList();
    } catch (e) {
      print("오류 발생");
      print(e);
      return [];
    }
  }

  Future<bool> addReview({
    required String content,
    required String mapx,
    required String mapy,
  }) async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection("reviews");
      // 3. 문서 참조 만들기
      final docRef = collectionRef.doc();
      // 4. 값 쓰기
      await docRef.set({
        "content": content,
        "mapx": mapx,
        "mapy": mapy,
        "createdAt": DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateReview({
    required String id,
    required String content,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection("reviews");
      final docRef = collectionRef.doc(id);
      await docRef.update({
        "content": content,
        "createdAt": DateTime.now().toIso8601String(),
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> deleteReview(String id) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection("reviews");
      final docRef = collectionRef.doc(id);
      await docRef.delete();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<List<Review>> reviewListStream() {
    try {
      final firestore = FirebaseFirestore.instance;
      final collectionRef = firestore.collection("reviews").orderBy("createdAt", descending: true);
      final stream = collectionRef.snapshots();
      final newStream = stream.map((event) {
        return event.docs.map(
          (e) {
            return Review.fromJson({
              "id": e.id,
              ...e.data(),
            });
          },
        ).toList();
      });
      return newStream;
    } catch (e) {
      print(e);
      return Stream.empty();
    }
  }
}

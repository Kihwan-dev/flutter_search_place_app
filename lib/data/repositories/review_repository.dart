import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewRepository {
  Future<void> getAll() async {
    try {
      // 1. 파이어스토어 인스턴스 가지고 오기
      final firestore = FirebaseFirestore.instance;
      // 2. 컬렉션 참조 만들기
      final collectionRef = firestore.collection("reviews");
      // 3. 값 불러오기
      final result = await collectionRef.get();

      final docs = result.docs;

      for (var doc in docs) {
        print(doc.id);
        print(doc.data());
      }
    } catch (e) {
      print("오류 발생");
      print(e);
      return;
    }
  }
}

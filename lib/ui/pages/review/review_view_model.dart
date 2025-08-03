import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/models/review.dart';
import 'package:flutter_search_place_app/data/repositories/review_repository.dart';

// 1. 상태 클래스 만들기
class ReviewState {
  bool isWriting;
  List<Review> reviews;
  ReviewState({
    required this.isWriting,
    required this.reviews,
  });
}

// 2. 뷰모델 만들기
class ReviewViewModel extends AutoDisposeFamilyNotifier<ReviewState, Place> {
  @override
  ReviewState build(Place arg) {
    return ReviewState(
      isWriting: false,
      reviews: [],
    );
  }

  Future<void> getReviews(double mapX, double mapY) async {
    final reviewRepo = ReviewRepository();
    final reviews = await reviewRepo.getReivewsByAddress(mapX: mapX, mapY: mapY);
    state = ReviewState(isWriting: false, reviews: reviews);
  }

  // 리뷰 작성
  Future<bool> addReview({
    required String content,
    required double mapX,
    required double mapY,
  }) async {
    final reviewRepo = ReviewRepository();
    state = ReviewState(isWriting: true, reviews: state.reviews);
    final result = await reviewRepo.addReview(content: content, mapX: mapX, mapY: mapY);
    await Future.delayed(Duration(milliseconds: 500));
    state = ReviewState(isWriting: false, reviews: state.reviews);
    return result;
  }
}

// 3. 뷰모델 관리자 만들기
final reviewViewModel = NotifierProvider.autoDispose.family<ReviewViewModel, ReviewState, Place>(() {
  return ReviewViewModel();
});

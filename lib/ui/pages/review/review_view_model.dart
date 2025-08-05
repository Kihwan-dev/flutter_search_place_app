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
    listenStream(arg.mapx, arg.mapy);

    // flutter task Future 우선순위

    return ReviewState(
      isWriting: false,
      reviews: [],
    );
  }

  final reviewRepo = ReviewRepository();

  Future<void> getReviews({
    required String mapx,
    required String mapy,
  }) async {
    final reviews = await reviewRepo.getReivewsByCoordinate(mapx: mapx, mapy: mapy);
    state = ReviewState(isWriting: false, reviews: reviews);
  }

  // 리뷰 작성
  Future<bool> addReview({
    required String content,
    required String mapx,
    required String mapy,
  }) async {
    final result = await reviewRepo.addReview(content: content, mapx: mapx, mapy: mapy);
    return result;
  }

  // 리뷰 수정
  Future<bool> editReview({
    required String id,
    required String content,
  }) async {
    final result = reviewRepo.updateReview(
      id: id,
      content: content,
    );
    return result;
  }

  // 리뷰 삭제
  Future<bool> deleteReview(String id) async {
    return await reviewRepo.deleteReview(id);
  }

  void listenStream(String mapx, String mapy) {
    final stream = reviewRepo.reviewListStream();
    final streamSubscription = stream.listen(
      (reviews) async {
        state = ReviewState(isWriting: true, reviews: state.reviews);
        final filterReivews = reviews
            .where(
              (review) => review.mapx == mapx && review.mapy == mapy,
            )
            .toList();
        await Future.delayed(Duration(milliseconds: 500));
        state = ReviewState(isWriting: false, reviews: filterReivews);
      },
    );

    ref.onDispose(() {
      streamSubscription.cancel();
    });
  }
}

// 3. 뷰모델 관리자 만들기
final reviewViewModel = NotifierProvider.autoDispose.family<ReviewViewModel, ReviewState, Place>(() {
  return ReviewViewModel();
});

// 1. 상태 클래스 만들기
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/repositories/place_repository.dart';

class HomeState {
  List<Place> places;
  HomeState(this.places);
}

// 2. 뷰모델 만들기 - Notifier 상속
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState([]);
  }

  Future<void> searchPlaces(String area) async {
    final placeRepo = PlaceRepository();
    final places = await placeRepo.searchPlaces(area);
    state = HomeState(places);
  }
}

// 3. 뷰모델 관리자 만들기 - NotifierProvider 객체
final homeViewModelProvider = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});

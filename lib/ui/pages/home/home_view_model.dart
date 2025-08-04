import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/core/geolocator_helper.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/repositories/place_repository.dart';
import 'package:flutter_search_place_app/data/repositories/vworld_repository.dart';
import 'package:geolocator/geolocator.dart';

// 1. 상태 클래스 만들기
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

  Future<String> searchByCurrentLocation() async {
    Position? position = await GeolocatorHelper.getPosition();
    if (position == null) {
      return "";
    }
    final vworldRepo = VworldRepository();
    final address = await vworldRepo.findByLatLng(position.latitude, position.longitude);
    searchPlaces(address);
    return address;
  }
}

// 3. 뷰모델 관리자 만들기 - NotifierProvider 객체
final homeViewModel = NotifierProvider<HomeViewModel, HomeState>(() {
  return HomeViewModel();
});

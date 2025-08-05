// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_search_place_app/core/geolocator_helper.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/repositories/place_repository.dart';
import 'package:flutter_search_place_app/data/repositories/vworld_repository.dart';

// 1. 상태 클래스 만들기
class HomeState {
  bool isSearching;
  List<Place> places;
  HomeState({
    required this.isSearching,
    required this.places,
  });
}

// 2. 뷰모델 만들기 - Notifier 상속
class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(isSearching: false, places: []);
  }

  Future<void> searchPlaces(String area) async {
    final placeRepo = PlaceRepository();
    state = HomeState(isSearching: true, places: state.places);
    final places = await placeRepo.searchPlaces(area);
    await Future.delayed(Duration(milliseconds: 500));
    state = HomeState(isSearching: false, places: places);
  }

  Future<String> searchByCurrentLocation() async {
    state = HomeState(isSearching: true, places: state.places);
    Position? position = await GeolocatorHelper.getPosition();
    if (position == null) {
      state = HomeState(isSearching: false, places: state.places);
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

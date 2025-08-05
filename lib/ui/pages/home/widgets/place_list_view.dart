import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/ui/pages/home/home_view_model.dart';
import 'package:flutter_search_place_app/ui/pages/review/review_page.dart';

class PlaceListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      List<Place> places = ref.watch(homeViewModel).places;
      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        itemCount: places.length,
        itemBuilder: (context, index) {
          final place = places[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewPage(place)));
            },
            child: _getPlaceCard(place),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        },
      );
    });
  }

  Container _getPlaceCard(Place place) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey[300]!,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            place.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(place.category),
          Text(place.roadAddress),
        ],
      ),
    );
  }
}

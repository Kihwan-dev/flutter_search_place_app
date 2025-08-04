import 'dart:convert';

import 'package:flutter_search_place_app/data/models/place.dart';
import 'package:flutter_search_place_app/data/repositories/base_remote_repository.dart';

class PlaceRepository extends BaseRemoteRepository {
  //
  Future<List<Place>> searchPlaces(String area) async {
    try {
      final response = await client.get(
        "",
        queryParameters: {
          "query": area,
          "display": 5,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.toString());
        return List.from(map["items"]).map((e) => Place.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}

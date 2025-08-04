import 'package:dio/dio.dart';

class VworldRepository {
  final Dio _client = Dio(BaseOptions(
    validateStatus: (status) {
      return true;
    },
  ));

  // 위도 경도로 검색
  Future<String> findByLatLng(double lat, double lng) async {
    // Future<List<String>> findByLatLng(double lat, double lng) async {
    // https://api.vworld.kr/req/data
    // request=GetFeature
    // key=7618D950-B50F-385B-A54D-DC26E2B17E02
    // data=LT_C_ADEMD_INFO
    // geomFilter=POINT(127.0929309 37.5353396)
    // geometry=false
    // siz=100
    try {
      final response = await _client.get(
        "https://api.vworld.kr/req/data",
        queryParameters: {
          "request": "GetFeature",
          "key": "7618D950-B50F-385B-A54D-DC26E2B17E02",
          "data": "LT_C_ADEMD_INFO",
          "geomFilter": "POINT($lng $lat)",
          "geometry": false,
          "size": 1,
        },
      );

      if (response.statusCode == 200 && response.data["response"]["status"] == "OK") {
        // response -> result -> featureCollection -> features => properties -> full_nm
        final features = response.data["response"]["result"]["featureCollection"]["features"];
        final featureList = List.from(features);
        return featureList[0]["properties"]["full_nm"];
      }

      return "";
    } catch (e) {
      print(e);
      return "";
    }
  }
}

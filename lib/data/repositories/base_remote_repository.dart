// 추상 클래스
// Dio 클라이언트 객체

import 'package:dio/dio.dart';

abstract class BaseRemoteRepository {
  Dio get client => _client;

  static Dio _client = Dio(
    BaseOptions(
      baseUrl: "https://openapi.naver.com/v1/search/local.json",
      // 설정 안할 시 실패 응답 오면 thorow 던져서 에러 발생
      validateStatus: (status) => true,
    ),
  )..interceptors.add(interceptor);

  static AuthInterceptor interceptor = AuthInterceptor();
}

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers.addAll({
      "X-Naver-Client-Id": "DGqHlCc0avd_B6AOMqXc",
      "X-Naver-Client-Secret": "fBbUnvQ7E7",
    });

    // 반드시 부모클래스의 onRequest를 호출해줘야함!!!!
    super.onRequest(options, handler);
  }
}

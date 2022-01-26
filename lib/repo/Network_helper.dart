import 'package:api_demo/repo/service_api_constants.dart';
import 'package:dio/dio.dart';


class NetworkHelper {



  Future<Dio> getApiClient(bool isAuth) async {
    var dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 600000,
      receiveTimeout: 600000,
      contentType: Headers.formUrlEncodedContentType,
      responseType: ResponseType.plain
    ));
    return dio;
  }

}

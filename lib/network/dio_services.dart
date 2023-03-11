import 'package:dio/dio.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/network/dio_interceptor.dart';

class DioService {
  static Interceptor interceptor = DioInterceptor();
  static Future<dynamic> postMethod({
    required RequestOptions requestOptions,
  }) async {
    Dio dio = Dio();
    dio.interceptors.add(interceptor);
    return await dio
        .post(requestOptions.path, data: requestOptions.data)
        .then((value) => value);
  }

  static Future<dynamic> getMethod(
      {required String url, String? baseUrl}) async {
    Dio dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? CustomStrings.backendUrl, receiveTimeout: 20000))
      ..interceptors.add(interceptor);
    return await dio.get(url).then((value) => value);
  }
}

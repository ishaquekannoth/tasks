import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:task/app/utils/custom_strings.dart';

class DioInterceptor extends Interceptor {
  // RequestRetrier requestRetrier;
  // DioInterceptor({required this.requestRetrier});
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    log("Caught error");
    if (_shouldStop(err)) {
      log(err.message.toString());
      handler.next(err);
    } else {
      log(err.message.toString());
      handler.next(err);
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log("Sucessfully send Request ");
    if (options.method == "POST") {
      options.headers = {
        'content-type': 'application/json',
        'Authorization': CustomStrings.notificationServerKey,
      };
      handler.next(options);
    } else {
      handler.next(options);
    }
  }

  bool _shouldStop(err) {
    return err.type == DioErrorType.other &&
            err.error != null &&
            err.error is SocketException ||
        (err.error == DioErrorType.receiveTimeout ||
            err.error == DioErrorType.connectTimeout ||
            err.error == DioErrorType.sendTimeout);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Sucessfully received Response ");
    handler.next(response);
  }
}

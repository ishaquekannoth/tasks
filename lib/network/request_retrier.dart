// import 'dart:async';
// import 'dart:developer';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:dio/dio.dart';

// class RequestRetrier {
//   final Dio dio;
//   final Connectivity connectivity;
//   RequestRetrier({required this.connectivity, required this.dio});

//   Future<Response> schedulerRequestRetry(RequestOptions requestOptions) async {
//     final responseCompleter = Completer<Response>();
//     log(requestOptions.baseUrl + requestOptions.path);
//     StreamSubscription? subscription;
//     subscription =
//         connectivity.onConnectivityChanged.listen((connectivityResult) {
//       if (connectivityResult != ConnectivityResult.none) {
//         subscription!.cancel();
//         responseCompleter.complete(dio.request(
//             options:
//                 Options(method: "GET"),
//             requestOptions.baseUrl + requestOptions.path,
//             cancelToken: requestOptions.cancelToken,
//             data: requestOptions.data,
//             onReceiveProgress: requestOptions.onReceiveProgress,
//             onSendProgress: requestOptions.onSendProgress,
//             queryParameters: requestOptions.queryParameters));
//       }
//     });

//     return responseCompleter.future;
//   }
// }

import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/app/utils/remote_config_utils.dart';
import 'package:task/core/route_setter.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/network/dio_services.dart';

Future<void> messageHandler(RemoteMessage message) async {
  log(message.data.toString());
}

class PushNotificationService {
  static late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static initializeAllServices() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await FirebaseMessaging.instance
        .getInitialMessage()
        .then((notificationData) {
      try {
        if (notificationData != null && notificationData.data.isNotEmpty) {
          log("Recieved==>products/${notificationData.data['body']}"
              .toString());
          DioService.getMethod(
                  url: 'products/${notificationData.data['body'].toString()}')
              .then((value) => ProductsModel.fromJson(value.data))
              .then((model) => {
                    RouteSetter().navigateToPdp = true,
                    RouteSetter().setProduct = model
                  });
        }
      } catch (e) {
        log("Notification Data is Null and void");
        return;
      }
    });
    FlutterError.onError = (errorDetails) async {
      await FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };

    FirebaseMessaging.onBackgroundMessage(messageHandler);
  }

  static Future requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        sound: true,
        provisional: true);
    await _initialiseLocalNotifications();
  }

  static Future _initialiseLocalNotifications() async {
    var androidSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosSettings = const DarwinInitializationSettings();
    var initialisationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);
    await flutterLocalNotificationsPlugin.initialize(
      initialisationSettings,
      onDidReceiveNotificationResponse: (notificationData) async {
        log("Iam printing notification.data.payload from did recieve notification");
        log('products/${notificationData.payload}');
        try {
          if (notificationData.payload != null) {
            Response response = await DioService.getMethod(
                url: 'products/${notificationData.payload}');
            log(response.data.toString());
            ProductsModel model = ProductsModel.fromJson(response.data);
            Get.toNamed(Routes.productDetails, arguments: model);
          }
        } catch (e) {
          log("Notification Data Null");
          return;
        }
      },
    );

    FirebaseMessaging.onMessage.listen((event) async {
      log("Message from firebase triggered");
      var bigStyleInfo = BigTextStyleInformation(
          event.notification!.body.toString(),
          htmlFormatBigText: true,
          contentTitle: event.notification!.title.toString(),
          htmlFormatContentTitle: true);
      var androidPlatform = AndroidNotificationDetails("task", "task",
          importance: Importance.high,
          styleInformation: bigStyleInfo,
          priority: Priority.max,
          playSound: true);
      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatform);

      await flutterLocalNotificationsPlugin.show(
          0,
          event.notification!.title.toString(),
          event.notification!.body.toString(),
          platformChannelSpecifics,
          payload: event.data["body"]);
    }).onError((object, stackTrace) => log("Operation failed successfully"));

    FirebaseMessaging.onMessageOpenedApp.listen((notificationData) async {
      log("Iam printing notification.data.payload from on messageOpenedApp");
      try {
        if (notificationData.data.isNotEmpty) {
          log("Recieved==>products/${notificationData.data['body']}"
              .toString());
          Response response = await DioService.getMethod(
              url: 'products/${notificationData.data['body'].toString()}');
          ProductsModel model = ProductsModel.fromJson(response.data);
          Get.offAndToNamed(Routes.productDetails, arguments: model);
        }
      } catch (e) {
        log("Notification Data is Null and void");
        return;
      }
    });
  }

  static Future getSetToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userId = pref.getString(CustomStrings.loggedInUserkey).toString();
    String? token = pref.getString(CustomStrings.fcmTokenKey);
    userId = userId.replaceAll(".", "_");
    log(userId);
    DocumentReference<Map<String, dynamic>> document =
        FirebaseFirestore.instance.collection("tokens").doc("DeviceId");
    DocumentSnapshot<Map<String, dynamic>> documentFileds =
        await document.get();
    if (documentFileds.exists && documentFileds.data()!.containsKey(userId)) {
      List<dynamic> data = documentFileds.data()!.values.first;
      if ((data.contains(token))) {
        log("Everything alll right,same device,same account");
        return;
      } else {
        log("Let me update the device token only");
        await document.update({
          userId: FieldValue.arrayUnion([token])
        });
      }
    } else {
      log("no user exists,Create new document fields");
      await document.set({
        userId: [token]
      }, SetOptions(merge: true));
    }
  }

  void sendTransactionalPushNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    log("requesting Send push notification to ==>${pref.getString(CustomStrings.fcmTokenKey).toString()}");
    await DioService.postMethod(
      requestOptions: RequestOptions(
        path: Uri.parse(CustomStrings.notificationApiUrl).toString(),
        data: {
          "priority": "high",
          "to": "${pref.getString(CustomStrings.fcmTokenKey)}",
          "notification": {
            "body": RemoteConfigUtils().notificationBody,
            "title": RemoteConfigUtils().notificationTitle,
          },
          "data": {
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "status": "done",
            "body": (math.Random().nextInt(20) + 1).toString(),
          }
        },
      ),
    );
  }
}

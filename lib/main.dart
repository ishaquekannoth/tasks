import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:task/core/routes.dart';
import 'package:task/domain/entities/firebase/dynamic_links.dart';
import 'package:task/domain/entities/push_notification/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  PushNotificationService.initializeAllServices();
  DynamicLinkService.initialiseLink();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      getPages: AppPages.pages,
      initialRoute: Routes.splashScreen,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
    );
  }
}

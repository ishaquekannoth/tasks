import 'dart:developer';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/core/route_setter.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/network/dio_services.dart';

class DynamicLinkService {
  Future<String> _createLink(String id) async {
    final fireBaseDynamicLink = FirebaseDynamicLinks.instance;
    String url =
        "${CustomStrings.backendUrl}${CustomStrings.allProductsUrl}/$id";
    final dynamicLinkParameters = DynamicLinkParameters(
        navigationInfoParameters:
            const NavigationInfoParameters(forcedRedirectEnabled: true),
        androidParameters: AndroidParameters(
            fallbackUrl: Uri.parse(CustomStrings.fallBackUrl.toString()),
            packageName: "com.learning.task",
            minimumVersion: 0),
        link: Uri.parse(url),
        uriPrefix: "https://ishaque.page.link");

    final link =
        await fireBaseDynamicLink.buildShortLink(dynamicLinkParameters);
    return link.shortUrl.toString();
  }

  static void initialiseLink() async {
    FirebaseDynamicLinks instance = FirebaseDynamicLinks.instance;
    await instance.getInitialLink().then((dynamicUrl) {
      if (dynamicUrl != null) {
        try {
          DioService.getMethod(url: dynamicUrl.link.toString(), baseUrl: "")
              .then((value) => ProductsModel.fromJson(value.data))
              .then((model) {
            RouteSetter().navigateToPdp = true;
            RouteSetter().setProduct = model;
          });
        } catch (e) {
          log(e.toString());
          return;
        }
      }
    });

    instance.onLink.listen((dynamicUrl) {
      try {
        DioService.getMethod(url: dynamicUrl.link.toString(), baseUrl: "")
            .then((value) => ProductsModel.fromJson(value.data))
            .then((model) {
          Get.toNamed(Routes.productDetails, arguments: model);
        });
      } catch (e) {
        log(e.toString());
        return;
      }
    });
  }

  shareProductLink(String id) async {
    _createLink(id).then((value) => Share.share(value));
  }
}

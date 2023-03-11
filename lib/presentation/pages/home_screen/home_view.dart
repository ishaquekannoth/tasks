import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/app/utils/dimensions.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/core/routes.dart';
import 'package:task/presentation/pages/home_screen/controller/home_controller.dart';
import 'package:task/presentation/pages/on_boarding/widget/build_dots.dart';

import 'widgets/product_tile_small.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        SliverAppBar(
          floating: true,
          centerTitle: true,
          title: const Text("D A S H B O A R D"),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
        )
      ],
      body: Obx(() => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : controller.productsList.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "oops!!..Some thing Went wrong..Click to retry",
                      style: CustomStyle.style,
                    ),
                    ElevatedButton(
                        onPressed: () => controller.fetchAllitems(),
                        child: const Text("Retry")),
                  ],
                )
              : ListView(
                  children: [
                    CarouselSlider(
                        items: controller.productsList
                            .take(6)
                            .map(
                              (element) => Card(
                                child: Container(
                                  width: size.width,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Center(
                                      child: Image.network(
                                        element.image.toString(),
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          return loadingProgress == null
                                              ? child
                                              : SizedBox(
                                                  height: size.width * 0.2,
                                                  child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  )));
                                        },
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList()
                            .reversed
                            .toList(),
                        options: CarouselOptions(
                            viewportFraction: 1,
                            autoPlay: true,
                            onPageChanged: (index, reason) =>
                                controller.dotsChanger(index))),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: BuildDots(
                        currentIndex: controller.dotsIndex.value,
                        dotsCount: 6,
                        dotsColor: const Color.fromARGB(255, 39, 132, 3),
                      ),
                    ),
                    headingText(
                        text: "Browse What we have in offer..",
                        width: size.width * 0.9),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: controller.productsList
                            .map((element) => ProductTileSmall(
                                  model: element,
                                  onTap: () => Get.toNamed(
                                      Routes.productDetails,
                                      arguments: element),
                                ))
                            .take(4)
                            .toList(),
                      ),
                    ),
                    headingText(
                        text: "Your aesthetics have something here in..",
                        width: size.width * 0.5),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.productsList
                              .where((element) =>
                                  element.category == CustomStrings.jewelery)
                              .map((data) => ProductTileSmall(
                                    model: data,
                                    onTap: () => Get.toNamed(
                                        Routes.productDetails,
                                        arguments: data),
                                  ))
                              .toList()),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: CustomDimensions.padding20, horizontal: 30),
                      child: Text(
                        "What we have in offer on electronics",
                        textAlign: TextAlign.start,
                        style: CustomStyle.style,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.productsList
                              .where((element) =>
                                  element.category == CustomStrings.electronics)
                              .map((data) => ProductTileSmall(
                                    model: data,
                                    onTap: () => Get.toNamed(
                                        Routes.productDetails,
                                        arguments: data),
                                  ))
                              .take(4)
                              .toList()),
                    ),
                    headingText(
                        text: "Clothing ideas for Her..",
                        width: size.width * 0.9),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.productsList
                              .where((element) =>
                                  element.category ==
                                  CustomStrings.womensClothing)
                              .map((data) => ProductTileSmall(
                                    model: data,
                                    onTap: () => Get.toNamed(
                                        Routes.productDetails,
                                        arguments: data),
                                  ))
                              .take(4)
                              .toList()),
                    ),
                    headingText(
                        text: "Unleash your Masculinity...",
                        width: size.width * 0.9),
                    SizedBox(
                      height: size.height * 0.25,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: controller.productsList
                              .where((element) =>
                                  element.category ==
                                  CustomStrings.mensClothing)
                              .map((data) => ProductTileSmall(
                                    model: data,
                                    onTap: () => Get.toNamed(
                                        Routes.productDetails,
                                        arguments: data),
                                  ))
                              .toList()),
                    ),
                  ],
                )),
    );
  }

  Widget headingText({required String text, required double width}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: CustomDimensions.padding20, horizontal: 30),
      child: SizedBox(
        width: width,
        child: Text(
          text,
          textAlign: TextAlign.start,
          style: CustomStyle.style,
        ),
      ),
    );
  }
}

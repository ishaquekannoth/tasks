import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/domain/repositories/home_repo/home_repository.dart';
import 'package:task/presentation/pages/category_listing/controller/category_listing_controller.dart';

import 'widgets/rectangular_category_card.dart';

class CategoryListingView extends GetView<CategoryListingController> {
  const CategoryListingView({super.key});
  @override
  Widget build(BuildContext context) {
    CategoryType itemType = Get.arguments;
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(itemType.name.toUpperCase()),
              centerTitle: true,
            ),
            body: Obx(() => Container(
                child: controller.selectedCategoryItemsList.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.selectedCategoryItemsList.length,
                        itemBuilder: (context, index) {
                          return RectangularCard(
                            product:
                                controller.selectedCategoryItemsList[index],
                            odd: index,
                          );
                        })
                    : controller.isListingLoading.value
                        ? Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Please wait while fetching the data..",
                                    style: CustomStyle.style,
                                  ),
                                  CircularProgressIndicator()
                                ]),
                          )
                        : Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Unable to Make the network request",
                                    style: CustomStyle.style,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        controller
                                            .fetchProductCategoryWise(itemType);
                                      },
                                      child: const Text("Retry"))
                                ]),
                          )))));
  }
}

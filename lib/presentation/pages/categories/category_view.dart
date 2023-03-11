import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/app/utils/custom_strings.dart';
import 'package:task/app/utils/themes.dart';
import 'package:task/core/routes.dart';
import 'package:task/data/models/products/product_model.dart';
import 'package:task/domain/repositories/home_repo/home_repository.dart';
import 'package:task/presentation/pages/categories/controller/category_controller.dart';
import 'package:task/presentation/pages/category_listing/controller/category_listing_controller.dart';

import 'widgets/category_card.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppBar(
          title: const Text(
            "C A T E G O R I E S",
            style: CustomStyle.style,
          ),
          centerTitle: true,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
          ),
          height: size.height * 0.5,
          child: Obx(() => Center(
              child: controller.categoryNameList.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.categoryNameList.length,
                      itemBuilder: (context, index) {
                        return Obx(() => CategoryCard(
                              onTap: () {
                                var ctrlr =
                                    Get.put(CategoryListingController());
                                index == 0
                                    ? ctrlr.fetchProductCategoryWise(
                                        CategoryType.electronics)
                                    : index == 1
                                        ? ctrlr.fetchProductCategoryWise(
                                            CategoryType.jewelery)
                                        : index == 2
                                            ? ctrlr.fetchProductCategoryWise(
                                                CategoryType.mensClothing)
                                            : ctrlr.fetchProductCategoryWise(
                                                CategoryType.womensClothing);
                                Get.toNamed(Routes.categoryListingScreen,
                                    arguments: index == 0
                                        ? CategoryType.electronics
                                        : index == 1
                                            ? CategoryType.jewelery
                                            : index == 2
                                                ? CategoryType.mensClothing
                                                : CategoryType.womensClothing);
                              },
                              productsModel: index == 0
                                  ? ProductsModel(
                                      category: "Electronics",
                                      image: CustomStrings.electronicsImage)
                                  : index == 1
                                      ? ProductsModel(
                                          category: "Jewelery",
                                          image: CustomStrings.jeweleryImage)
                                      : index == 2
                                          ? ProductsModel(
                                              category: "Mens Clothing",
                                              image: CustomStrings
                                                  .mensClothingImage)
                                          : ProductsModel(
                                              category: "Womens clothing",
                                              image: CustomStrings
                                                  .womensClothingImage),
                              bottomText: controller.categoryNameList[index]
                                  .toUpperCase(),
                            ));
                      })
                  : controller.isLoading.value
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
                      : Obx(() => Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    "oops!! server unreachable..Click to retry...",
                                    style: CustomStyle.style,
                                  ),
                                ],
                              ),
                              controller.isLoading.value
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () =>
                                          controller.categoryListPopulator(),
                                      child: const Text("Retry")),
                            ],
                          )))),
        ),
      ],
    );
  }
}

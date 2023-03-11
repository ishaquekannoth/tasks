import 'package:get/get.dart';
import 'package:task/domain/repositories/category_repo/category_repo.dart';

class CategoryController extends GetxController {
  @override
  void onInit() {
    categoryListPopulator();
    super.onInit();
  }

  RxBool isLoading = true.obs;
  RxList<String> categoryNameList = <String>[].obs;

  categoryListPopulator() async {
    try {
      isLoading.value = true;
      List<String> categoryData =
          await CategoryRepository.fetchAllCategoryHeads();
      categoryNameList
        ..clear()
        ..addAll(categoryData);
    } finally {
      isLoading.value = false;
    }
  }
}

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../home_screen/model/category_list_model.dart';

class AllCategoryController extends GetxController{
  RxList<CategoryItem> categoryList = <CategoryItem>[].obs;

  @override
  void onInit() {
    categoryList.addAll(Get.arguments["category-list"]);
    Logger().e(categoryList.length);
    super.onInit();
  }
}
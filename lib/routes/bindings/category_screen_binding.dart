
import 'package:get/get.dart';
import 'package:luggage_tracking/screens/category_screnn/controller/all_category_controller.dart';

class CategoryScreenBinding extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => AllCategoryController());


  }
}

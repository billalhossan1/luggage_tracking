import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';


class HomeScreenController extends GetxController{
  RxBool categoryIsLoading = false.obs;
  RxBool productIsLoading = false.obs;
  RxString message = ''.obs;
  RxString errorMessage = ''.obs;
  RxList<CategoryItem> categoryList = <CategoryItem>[].obs;
  RxList<ProductItem> productList = <ProductItem>[].obs;


    @override
  void onInit() {
      Logger().i("HomeScreenController initialized");
      getCategoryList();
      getProductList();
      Logger().i("Category list fetched: ${categoryList.length} items");
      Logger().i("Product list fetched: ${productList.length} items");
    super.onInit();
  }



  Future<void> getCategoryList() async {
    Logger().i("getCategoryList called");
    categoryIsLoading.value = true;
    try {
      final response = await categoryApicall();
      Logger().i("API response received");
      if (response.isSuccess) {
        var data = response.responseData;
        CategoryListModel categoryListModel = CategoryListModel.fromJson(data);
        categoryList.addAll(categoryListModel.categoryList ?? []);
        message.value = "Category list fetched successfully";
        Logger().i("Category list updated: ${categoryList.length} items");
      } else {
        errorMessage.value = response.errorMessage ?? "Failed to fetch category list";
        Logger().e("Error message: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      Logger().e(errorMessage.value);
    } finally {
      categoryIsLoading.value = false;
    }
  }
  Future<void> getProductList() async {
    productIsLoading.value = true;
    try {
      final response = await productApicall();
      if (response.isSuccess) {
        var data = response.responseData;
        ProductListModel productListModel = ProductListModel.fromJson(data);
        productList.addAll(productListModel.productList ?? []);
        Logger().i("Product list updated: ${productList.length} items");
        message.value = "Product list fetched successfully";
      } else {
        errorMessage.value = response.errorMessage ?? "Failed to fetch product list";
        Logger().e("Error message: ${errorMessage.value}");
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      Logger().e(errorMessage.value);
    } finally {
      productIsLoading.value = false;
    }
  }


  Future<dynamic>categoryApicall()async {
    final networkCaller = Get.find<NetworkCaller>();
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    return networkCaller.getRequest(
        Urls.getCategoryListUrl, accessToken: accessToken);
  }
  Future<dynamic>productApicall()async {
    final networkCaller = Get.find<NetworkCaller>();
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    return networkCaller.getRequest(
        Urls.getProductListUrl, accessToken: accessToken);
  }
}
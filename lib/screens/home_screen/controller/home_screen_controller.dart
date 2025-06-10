import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/screens/account_screen/controller/account_controller.dart';
import 'package:luggage_tracking/screens/account_screen/model/profile_model.dart';
import 'package:luggage_tracking/screens/home_screen/model/category_list_model.dart';
import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';
import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';


class HomeScreenController extends GetxController{
  RxBool categoryIsLoading = false.obs;
  RxBool productIsLoading = false.obs;
  RxString message = ''.obs;
  RxString errorMessage = ''.obs;
  RxBool bookMarkLoading = false.obs;
  RxList<CategoryItem> categoryList = <CategoryItem>[].obs;
  RxList<ProductItem> productList = <ProductItem>[].obs;

  @override
  void onInit() {
    Logger().i("HomeScreenController initialized");
    getCategoryList();
    getProductList();
    Get.find<AccountController>().getProfileDetails();
    // Logger().i("Category list fetched: ${categoryList.length} items");
    // Logger().i("Product list fetched: ${productList.length} items");
    super.onInit();
  }

  Future<void> onBookMarkTogle(ProductItem product) async {
    // bookMarkApiCall(product.sId!);
    // Toggle the bookmark locally
    // Logger().i("onBookMarkTogle called for product: ${product.sId}, isBookMarked: ${product.bookmark}");
    if(product.bookmark==true){
      product.bookmark = false;
    }else{
      product.bookmark = true;
    }
    update();
    final NetworkResponse response =await bookMarkApiCall(product.sId!);

    // if(response.isSuccess){
    //
    // }
 //  Toggle the bookmark status locally
// Update the UI with the new state

    // Trigger the API call to update the bookmark status

  }

  Future<dynamic> bookMarkApiCall(String productID) async {
    Logger().i("bookMarkApiCall triggered for product: $productID");
    Map<String, dynamic> body = {
      "product": productID,
    };

    if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(() => SaveDataController());
      Get.lazyPut(() => NetworkCaller());
    }

    String? accessToken = await Get.find<SaveDataController>().getUserData();
    Logger().i("Access token: $accessToken");

    if (accessToken == null) {
      Logger().e("Access Token is null");
      return;
    }
    bookMarkLoading.value=true;
    final response = await Get.find<NetworkCaller>().postRequest(
      Urls.bookMarkUrl,
      body: body,
      accessToken: accessToken,
    );
    bookMarkLoading.value=false;

    // Logger().i("Bookmark API Response: Status Code - ${response.statusCode}");
    // Logger().i("Bookmark API Response Body: ${response.responseData}");

    if (response.isSuccess) {
      AppSnackBar.message(response.responseData['message'] ?? "Bookmark toggled successfully");
    } else {
      AppSnackBar.error(response.errorMessage ?? "Failed to toggle bookmark");
      // Revert the bookmark status locally if API fails
      final product = productList.firstWhere((p) => p.sId == productID);
      product.bookmark = product.bookmark;  // Revert
      update();  // Update the UI with the reverted state
    }
    return response;
  }

  Future<void> getCategoryList() async {
    Logger().i("getCategoryList called");
    categoryIsLoading.value = true;
    try {
      final response = await categoryApicall();
      Logger().i("API response received");
      if (response.isSuccess) {
        categoryList.clear();
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
        productList.clear();
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

  Future<dynamic> categoryApicall() async {
    if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(() => SaveDataController());
      Get.lazyPut(() => NetworkCaller());
    }
    final networkCaller = Get.find<NetworkCaller>();
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    // _accessToken = accessToken;
    return networkCaller.getRequest(
        Urls.getCategoryListUrl, accessToken: accessToken);
  }
  Future<void> onRefresh()async{
    getCategoryList();
    getProductList();

  }

  Future<dynamic> productApicall() async {
    if (!Get.isRegistered<SaveDataController>() && !Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(() => SaveDataController());
      Get.lazyPut(() => NetworkCaller());
    }
    final networkCaller = Get.find<NetworkCaller>();
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    // Logger().e("Product Access Token: $_accessToken");
    return networkCaller.getRequest(
        Urls.getProductListUrl, accessToken: accessToken);
  }
}

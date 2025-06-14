import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class ProductCategoryScreenController extends GetxController{
  RxString catId = ''.obs;
  int currentPage = 1;
  int totalPages = 1;
  int limit = 10;
  @override
  void onInit() {
    catId.value = Get.arguments['category-id'];
    super.onInit();
  }
  
  
  Future<dynamic>apiCall()async{
    Map<String,dynamic>queryParams={};
    final String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = await Get.find<NetworkCaller>().getRequest(Urls.getProductListUrl,accessToken: accessToken,queryParam: queryParams);
  }
}
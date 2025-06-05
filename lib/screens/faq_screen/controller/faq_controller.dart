import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/faq_screen/model/faq_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class FaqController extends GetxController {
  // Expanded tile index. -1 means no tile is expanded.
  var expandedIndex = (-1).obs;
  RxList<FAQItem> faqList = <FAQItem>[].obs;
  RxBool isLoading = false.obs;

  // Toggle expanded state for a specific tile
  void toggleExpanded(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // If the same tile is clicked, collapse it.
    } else {
      expandedIndex.value = index; // Otherwise, expand the clicked tile.
    }
    update();
  }
  @override
  onInit() {
    super.onInit();
    Logger().i("FaqController initialized");
    getFaqList();
  }
  
  Future<dynamic>faqApiCall() async {

    if (!Get.isRegistered<NetworkCaller>()) {
      Get.lazyPut(() => NetworkCaller());
      Get.lazyPut(() => SaveDataController());
    }
    String? accessToken = await Get.find<SaveDataController>().getUserData();
   final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(Urls.getFAQListUrl,accessToken: accessToken );
   return response;
  }


  Future<void>getFaqList() async {

    isLoading.value = true;
    try {
      final response = await faqApiCall();
      if (response.isSuccess) {
        faqList.clear();
        var data = response.responseData;
        FAQModel faqModel = FAQModel.fromJson(data);
        faqList.addAll(faqModel.FAQList ?? []);
        Logger().i("FAQ list fetched successfully: ${faqList.length} items");
      } else {
        // Handle error case
        print("Error fetching FAQ list: ${response.errorMessage}");
      }
    } catch (e) {
      print("An error occurred while fetching FAQ list: $e");
    } finally {
      isLoading.value = false;
    }
  }
}



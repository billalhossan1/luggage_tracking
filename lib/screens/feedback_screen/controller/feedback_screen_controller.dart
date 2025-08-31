import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/api/network_response.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

class FeedbackScreenController extends GetxController {

  // RxString message = ''.obs;
  // RxInt ratting = 0.obs;

  Future<dynamic> feedbackApiCall(String message,double ratting) async {
    if (!Get.isRegistered<NetworkCaller>() ||
        !Get.isRegistered<SaveDataController>()) {
      Get.lazyPut(() => NetworkCaller());
      Get.lazyPut(() => SaveDataController());
    }
    Map<String,dynamic>body={
      "comment":message,
      "rating":ratting
    };
    String? accessToken = await SaveDataController().getUserData();
    final NetworkResponse response = await Get.find<NetworkCaller>().postRequest(
      Urls.feedbackUrl,
      body: body,
      accessToken: accessToken,
    );
    return response;
  }
  Future<void>makeFeedBack(String message,double ratting)async{


      final NetworkResponse response = await feedbackApiCall(message ,ratting);
      if(response.isSuccess){
        AppSnackBar.message(response.responseData["message"]??'FeedBack Submitted Successfully');
      }else{
        AppSnackBar.error(response.errorMessage);
      }
  }
}

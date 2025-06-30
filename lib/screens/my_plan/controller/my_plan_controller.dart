
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:luggage_tracking/screens/my_plan/model/my_plan_model.dart';
import 'package:luggage_tracking/widgets/app_snack_bar/app_snack_bar.dart';

import '../../../const/urls/urls.dart';
import '../../../services/api/network_caller.dart';
import '../../../services/api/network_response.dart';
import '../../../services/save_data/save_data.dart';
import '../../../utils/app_all_log/error_log.dart';
import '../../../widgets/snackbar_message/snackBar_widget.dart';

class MyPlanController extends GetxController {

  bool isLoading = false;
  MyPlan? myPlan;
  String? planName;
  int? price;
  String? month;
  String? startDate;
  String? expireDate;
  String? status;

  @override
  void onInit() {
    getMyPlan();
    super.onInit();
  }

  Future<dynamic> apiCall() async {
    final String? accessToken = await Get.find<SaveDataController>().getUserData();
    Logger().i("accessToken : ${accessToken}");
    final response = await Get.find<NetworkCaller>().getRequest(Urls.myPlanUrl, accessToken: accessToken);
    return response;
  }

  Future<void> getMyPlan() async {
    try {
      isLoading = true;
      update();
      final NetworkResponse response = await apiCall();
      isLoading = false;
      update();
      if (response.isSuccess) {
        MyPlanModel myPlanModel = MyPlanModel.fromJson(response.responseData);
        myPlan = myPlanModel.myPlan;
        planName = myPlan?.plan?.title;
        price = myPlan?.price;
        // Logger().i("${myPlan?.plan?.title}");
        if(myPlan!.currentPeriodStart != null)
        {
          String planStartDate = formatDate(DateTime.parse(myPlan?.currentPeriodStart ?? ''));
          startDate = planStartDate;
        }
        if(myPlan!.currentPeriodEnd!=null){
          String planEndDate = formatDate(DateTime.parse(myPlan?.currentPeriodEnd ?? ''));
          expireDate = planEndDate;
        }


        status = myPlan?.status;
        month = myPlan?.plan?.duration;
        update();
      } else {
        AppSnackBar.error("Something went wrong");
      }
    } catch (e) {
      errorLog(e.toString(), e);
    }
  }

  List<Map<String, String>> get details {
    return [
      {'label': 'Plan Name', 'value': '$planName' },
      {'label': 'Price', 'value': '$price'},
      {'label': 'Duration', 'value': '$month'},
      {'label': 'Start Date', 'value': '$startDate'},
      {'label': 'Expired Date', 'value': '$expireDate'},
      {'label': 'Status', 'value': '$status'},
    ];
  }

  String formatDate(DateTime dateTime) {
    try {
      // Format the DateTime object to DD/MM/YYYY
      return DateFormat('dd/MM/yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid Date'; // In case the date format is incorrect
    }
  }
}

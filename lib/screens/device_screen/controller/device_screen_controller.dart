import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class DeviceScreenController extends GetxController {
  RxInt selectedItem = 1.obs;

  void selectItem(int? value) {
    selectedItem.value = value ?? 1;
  }

  Future<void>getDevices ()async{

  }

  Future<dynamic>apiCall()async{
    String? accessToken = await Get.find<SaveDataController>().getUserData();
    final response = Get.find<NetworkCaller>().getRequest(Urls.getDevicesUrl,accessToken: accessToken);
    return response;
  }
}

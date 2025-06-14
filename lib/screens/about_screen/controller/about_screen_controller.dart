import 'package:get/get.dart';
import 'package:luggage_tracking/const/urls/urls.dart';
import 'package:luggage_tracking/screens/terms_and_condition_screen/model/terms_and_condition_model.dart';
import 'package:luggage_tracking/services/api/network_caller.dart';
import 'package:luggage_tracking/services/save_data/save_data.dart';

class AboutScreenController extends GetxController{
  final RxBool _inProgress = false.obs;
  final RxString _errorMessage = ''.obs;
  bool get inProgress => _inProgress.value;
  String get errorMessage => _errorMessage.value;
  final RxString _aboutTextHtml = ''.obs;
  String get aboutTextHtml => _aboutTextHtml.value;

  @override
  onInit() {
    super.onInit();
    getAboutUs();
  }


  Future<bool> getAboutUs() async {

    _inProgress.value = true;
    _errorMessage.value = '';


    // String? tempToken = Get.find<SaveDataController>().tempToken!;
    String? token = await Get.find<SaveDataController>().getUserData();
    // token ??= tempToken;

    final response = await Get.find<NetworkCaller>().getRequest(
      Urls.aboutUrl,
      accessToken: token,
    );


    if (response.isSuccess) {
      try {
        final json = response.responseData;
        final termAndConditionModel = TermsAndConditionModel.fromJson(json);

        _aboutTextHtml.value = termAndConditionModel.data?.content ?? '';


        _inProgress.value = false;

        return true;
      } catch (e) {
        _errorMessage.value = 'Failed to parse data: $e';
      }
    } else {
      _errorMessage.value = response.errorMessage;
    }

    _inProgress.value = false;
    return false;
  }
}
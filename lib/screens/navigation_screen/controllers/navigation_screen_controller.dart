
import 'package:get/get.dart';

import '../../../services/save_data/save_data.dart';

/////////  variable
// AppUserData? appUserData;
// Rx<AppUserData> appUserData = AppUserData().obs;

class NavigationScreenController extends GetxController {
  RxInt selectedIndex = RxInt(0);

   bool isExpanded = false;

  void toggleExpansion() {
    isExpanded = !isExpanded;
    update(); // Notifies GetBuilder to rebuild
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  ////////////////  notification
  // callNotification() {
  //   showGeneralDialog(
  //     context: Get.context!,
  //     barrierColor: Colors.transparent,
  //     transitionDuration: Duration(milliseconds: 1000),
  //     pageBuilder: (context, animation, secondaryAnimation) {
  //       // return const NotificationScreen();
  //     },
  //     transitionBuilder: (context, animation, secondaryAnimation, child) {
  //       return SlideTransition(
  //         position: CurvedAnimation(parent: animation, curve: Curves.easeInOut).drive(Tween<Offset>(
  //           begin: const Offset(0, -1.0),
  //           end: Offset.zero,
  //         )),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  void initialDataSetUp() {
    // try {
    //   final argData = Get.arguments;
    //   if (argData.runtimeType != Null) {
    //     appUserData.value = argData;
    //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //       update();
    //     });
    //   }
    // } catch (e) {
    //   errorLog("navigation screen initial data setup function", e);
    // }
  }
  bool isSubscribe= false;
  @override
  void onInit() {
    initial();
    super.onInit();
  }
  void initial()async{
    if(!Get.isRegistered<SaveDataController>()){
      Get.lazyPut(()=>SaveDataController());
    }
    isSubscribe=await SaveDataController().getIsSubscribe();

    initialDataSetUp();

  }



  // @override
  // void onClose() {
  //   appUserData.dispose();
  //   super.onClose();
  // }
}

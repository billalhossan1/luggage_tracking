

import 'package:get/get.dart';
import 'package:luggage_tracking/const/assets_images_path.dart';

class CustomerEventInfoController extends GetxController {
  // final images = [
  //   'https://picsum.photos/id/1015/400/300',
  //   'https://picsum.photos/id/1016/400/300',
  //   'https://picsum.photos/id/1018/400/300',
  //   'https://cdn.pixabay.com/photo/2025/03/31/21/30/italy-9505446_960_720.jpg',
  // ];
  final images = [
    AssetsImagesPath.instance.product1,
    AssetsImagesPath.instance.product2,
    AssetsImagesPath.instance.product1,
    AssetsImagesPath.instance.product2,
  ];

  String selectedImage = AssetsImagesPath.instance.product1;

  void selectImage(String img) {
    selectedImage = img;
    update(); // 🔴 important
  }
}

import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';


class ProductDetailsModel {

  ProductItem? productItem;

  ProductDetailsModel({ this.productItem});

  ProductDetailsModel.fromJson(Map<String, dynamic> json) {

    productItem = json['data'] != null ? ProductItem.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (productItem != null) {
      data['data'] = productItem!.toJson();
    }
    return data;
  }
}



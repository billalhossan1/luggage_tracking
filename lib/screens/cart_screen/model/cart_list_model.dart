import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';

class CartListModel {
  bool? success;
  String? message;
  List<CartItem>? cartList;

  CartListModel({this.success, this.message, this.cartList});

  CartListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      cartList = <CartItem>[];
      json['data'].forEach((v) {
        cartList!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (cartList != null) {
      data['data'] = cartList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  String? sId;
  int? quantity;
  ProductItem? product;

  CartItem({this.sId, this.quantity, this.product});

  CartItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ?  ProductItem.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['quantity'] = quantity;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

// class Product {
//   String? sId;
//   String? name;
//   List<String>? images;
//   int? price;
//   String? color;
//
//   Product({this.sId, this.name, this.images, this.price, this.color});
//
//   Product.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     images = json['images'].cast<String>();
//     price = json['price'];
//     color = json['color'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['_id'] = sId;
//     data['name'] = name;
//     data['images'] = images;
//     data['price'] = price;
//     data['color'] = color;
//     return data;
//   }
// }

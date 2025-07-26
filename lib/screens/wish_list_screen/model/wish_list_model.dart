import 'package:luggage_tracking/screens/home_screen/model/product_list_model.dart';

class WishListModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<WishItem>? wishList;

  WishListModel({this.success, this.message, this.pagination, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      wishList = <WishItem>[];
      json['data'].forEach((v) {
        wishList!.add(WishItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (wishList != null) {
      data['data'] = wishList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pagination {
  int? total;
  int? totalPage;
  int? page;
  int? limit;

  Pagination({this.total, this.totalPage, this.page, this.limit});

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    totalPage = json['totalPage'];
    page = json['page'];
    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['totalPage'] = totalPage;
    data['page'] = page;
    data['limit'] = limit;
    return data;
  }
}

class WishItem {
  String? sId;
  ProductItem? product;

  WishItem({this.sId, this.product});

  WishItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? ProductItem.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

// class WishProduct {
//   String? sId;
//   String? name;
//   String? description;
//   List<String>? images;
//   String? category;
//   int? price;
//   String? status;
//   String? color;
//   String? createdAt;
//   String? updatedAt;
//   int? iV;
//
//
//   WishProduct(
//       {this.sId,
//         this.name,
//         this.description,
//         this.images,
//         this.category,
//         this.price,
//         this.status,
//         this.color,
//         this.createdAt,
//         this.updatedAt,
//         this.iV});
//
//   WishProduct.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     name = json['name'];
//     description = json['description'];
//     images = json['images'].cast<String>();
//     category = json['category'];
//     price = json['price'];
//     status = json['status'];
//     color = json['color'];
//     createdAt = json['createdAt'];
//     updatedAt = json['updatedAt'];
//     iV = json['__v'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['images'] = this.images;
//     data['category'] = this.category;
//     data['price'] = this.price;
//     data['status'] = this.status;
//     data['color'] = this.color;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['__v'] = this.iV;
//     return data;
//   }
// }



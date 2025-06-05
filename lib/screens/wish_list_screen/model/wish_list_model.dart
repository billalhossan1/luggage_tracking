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
        ? new Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      wishList = <WishItem>[];
      json['data'].forEach((v) {
        wishList!.add(new WishItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    if (this.wishList != null) {
      data['data'] = this.wishList!.map((v) => v.toJson()).toList();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['totalPage'] = this.totalPage;
    data['page'] = this.page;
    data['limit'] = this.limit;
    return data;
  }
}

class WishItem {
  String? sId;
  WishProduct? product;

  WishItem({this.sId, this.product});

  WishItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
    json['product'] != null ? new WishProduct.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class WishProduct {
  String? sId;
  String? name;
  String? description;
  List<String>? images;
  String? category;
  int? price;
  String? status;
  String? color;
  String? createdAt;
  String? updatedAt;
  int? iV;

  WishProduct(
      {this.sId,
        this.name,
        this.description,
        this.images,
        this.category,
        this.price,
        this.status,
        this.color,
        this.createdAt,
        this.updatedAt,
        this.iV});

  WishProduct.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    category = json['category'];
    price = json['price'];
    status = json['status'];
    color = json['color'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['images'] = this.images;
    data['category'] = this.category;
    data['price'] = this.price;
    data['status'] = this.status;
    data['color'] = this.color;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

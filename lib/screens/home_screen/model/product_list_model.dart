class ProductListModel {
  bool? success;
  String? message;
  Pagination? pagination;
  List<ProductItem>? productList;

  ProductListModel({this.success, this.message, this.pagination, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
    if (json['data'] != null) {
      productList = <ProductItem>[];
      json['data'].forEach((v) {
        productList!.add(ProductItem.fromJson(v));
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
    if (productList != null) {
      data['data'] = productList!.map((v) => v.toJson()).toList();
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

class ProductItem {
  String? sId;
  String? name;
  String? description;
  List<String>? images;
  Category? category;
  int? price;
  String? status;
  String? color;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? bookmark;

  ProductItem(
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
        this.iV,
        this.bookmark});

  ProductItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    price = json['price'];
    status = json['status'];
    color = json['color'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    bookmark = json['bookmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['description'] = description;
    data['images'] = images;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['price'] = price;
    data['status'] = status;
    data['color'] = color;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['bookmark'] = bookmark;
    return data;
  }
}

class Category {
  String? sId;
  String? name;

  Category({this.sId, this.name});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}

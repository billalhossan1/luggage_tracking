class OrderListModel {
  bool? success;
  String? message;
  Data? data;

  OrderListModel({this.success, this.message, this.data});

  OrderListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Order>? orders;
  Pagination? pagination;

  Data({this.orders, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Order>[];
      json['orders'].forEach((v) {
        orders!.add(Order.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Order {
  String? sId;
  String? email;
  String? contact;
  String? address;
  String? user;
  Product? product;
  int? quantity;
  dynamic price;
  String? txid;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Order(
      {this.sId,
        this.email,
        this.contact,
        this.address,
        this.user,
        this.product,
        this.quantity,
        this.price,
        this.txid,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Order.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    contact = json['contact'];
    address = json['address'];
    user = json['user'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    price = json['price'];
    txid = json['txid'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['email'] = email;
    data['contact'] = contact;
    data['address'] = address;
    data['user'] = user;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['price'] = price;
    data['txid'] = txid;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Product {
  String? sId;
  String? name;
  List<String>? images;

  Product({this.sId, this.name, this.images});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['images'] = images;
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

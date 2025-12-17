class DeviceModel {
  bool? success;
  String? message;
  Data? data;

  DeviceModel({this.success, this.message, this.data});

  DeviceModel.fromJson(Map<String, dynamic> json) {
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
  List<Devices>? devices;
  Pagination? pagination;

  Data({this.devices, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['devices'] != null) {
      devices = <Devices>[];
      json['devices'].forEach((v) {
        devices!.add(Devices.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (devices != null) {
      data['devices'] = devices!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    return data;
  }
}

class Devices {
  String? sId;
  String? user;
  String? name;
  String? connectionType;
  String? deviceMac;
  Category? category;
  String? status;
  String? serial;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Devices(
      {this.sId,
        this.user,
        this.name,
        this.category,
        this.connectionType,
        this.deviceMac,
        this.serial,
        this.status,
        this.createdAt,
        this.updatedAt,

        this.iV});

  Devices.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    name = json['name'];
    category = json['category'] != null
        ? Category.fromJson(json['category'])
        : null;
    serial = json['serial'];
    connectionType = json['connectionType'];
    deviceMac = json['deviceMac'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    data['name'] = name;
    data['status'] = status;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['serial'] = serial;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Category {
  String? sId;
  String? name;
  String? image;

  Category({this.sId, this.name, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
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

class CategoryListModel {
  bool? success;
  String? message;
  List<CategoryItem>? categoryList;

  CategoryListModel({this.success, this.message, this.categoryList});

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      categoryList = <CategoryItem>[];
      json['data'].forEach((v) {
        categoryList!.add(CategoryItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (categoryList != null) {
      data['data'] = categoryList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryItem {
  String? sId;
  String? name;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CategoryItem(
      {this.sId,
        this.name,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CategoryItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['image'] = image;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

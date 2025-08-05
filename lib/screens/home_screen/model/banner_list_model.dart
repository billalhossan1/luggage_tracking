class BannerListModel {

  List<BannerItem>? bannerList;

  BannerListModel({this.bannerList});

  BannerListModel.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      bannerList = <BannerItem>[];
      json['data'].forEach((v) {
        bannerList!.add(BannerItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (bannerList != null) {
      data['data'] = bannerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BannerItem {
  String? sId;
  String? name;
  String? product;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? iV;

  BannerItem(
      {this.sId,
        this.name,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.iV});

  BannerItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    product = json['product'];
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

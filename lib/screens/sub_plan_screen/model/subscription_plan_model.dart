class SubscriptionPlanModel {
  bool? success;
  String? message;
  List<Plan>? plans;

  SubscriptionPlanModel({this.success, this.message, this.plans});

  SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];

    // Check if plans are directly in the response or inside 'data'
    if (json['plans'] != null) {
      plans = <Plan>[];
      json['plans'].forEach((v) {
        plans!.add(Plan.fromJson(v));
      });
    } else if (json['data'] != null) {
      plans = <Plan>[];
      json['data'].forEach((v) {
        plans!.add(Plan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (plans != null) {
      data['plans'] = plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plan {
  String? sId;
  String? title;
  String? description;
  int? price;
  String? duration;
  String? paymentType;
  String? productId;
  String? paymentLink;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Plan(
      {this.sId,
        this.title,
        this.description,
        this.price,
        this.duration,
        this.paymentType,
        this.productId,
        this.paymentLink,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Plan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    duration = json['duration'];
    paymentType = json['paymentType'];
    productId = json['productId'];
    paymentLink = json['paymentLink'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['duration'] = duration;
    data['paymentType'] = paymentType;
    data['productId'] = productId;
    data['paymentLink'] = paymentLink;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

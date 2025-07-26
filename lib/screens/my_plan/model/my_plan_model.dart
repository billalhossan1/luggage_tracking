class MyPlanModel {

  MyPlan? myPlan;

  MyPlanModel({ this.myPlan});

  MyPlanModel.fromJson(Map<String, dynamic> json) {

    myPlan = json['data'] != null ? MyPlan.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (myPlan != null) {
      data['data'] = myPlan!.toJson();
    }
    return data;
  }
}

class MyPlan {
  String? sId;
  String? customerId;
  int? price;
  String? user;
  Plan? plan;
  String? trxId;
  String? subscriptionId;
  String? currentPeriodStart;
  String? currentPeriodEnd;
  String? status;


  MyPlan(
      {this.sId,
        this.customerId,
        this.price,
        this.user,
        this.plan,
        this.trxId,
        this.subscriptionId,
        this.currentPeriodStart,
        this.currentPeriodEnd,
        this.status,
});

  MyPlan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    customerId = json['customerId'];
    price = json['price'];
    user = json['user'];
    plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
    trxId = json['trxId'];
    subscriptionId = json['subscriptionId'];
    currentPeriodStart = json['currentPeriodStart'];
    currentPeriodEnd = json['currentPeriodEnd'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['customerId'] = customerId;
    data['price'] = price;
    data['user'] = user;
    if (plan != null) {
      data['plan'] = plan!.toJson();
    }
    data['trxId'] = trxId;
    data['subscriptionId'] = subscriptionId;
    data['currentPeriodStart'] = currentPeriodStart;
    data['currentPeriodEnd'] = currentPeriodEnd;
    data['status'] = status;

    return data;
  }
}

class Plan {
  String? sId;
  String? title;
  int? price;
  String? duration;

  Plan({this.sId, this.title, this.price, this.duration});

  Plan.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    duration = json['duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['price'] = price;
    data['duration'] = duration;
    return data;
  }
}

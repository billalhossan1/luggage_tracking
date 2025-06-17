class MyPlanModel {

  MyPlan? myPlan;

  MyPlanModel({ this.myPlan});

  MyPlanModel.fromJson(Map<String, dynamic> json) {

    myPlan = json['data'] != null ? new MyPlan.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.myPlan != null) {
      data['data'] = this.myPlan!.toJson();
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
    plan = json['plan'] != null ? new Plan.fromJson(json['plan']) : null;
    trxId = json['trxId'];
    subscriptionId = json['subscriptionId'];
    currentPeriodStart = json['currentPeriodStart'];
    currentPeriodEnd = json['currentPeriodEnd'];
    status = json['status'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['customerId'] = this.customerId;
    data['price'] = this.price;
    data['user'] = this.user;
    if (this.plan != null) {
      data['plan'] = this.plan!.toJson();
    }
    data['trxId'] = this.trxId;
    data['subscriptionId'] = this.subscriptionId;
    data['currentPeriodStart'] = this.currentPeriodStart;
    data['currentPeriodEnd'] = this.currentPeriodEnd;
    data['status'] = this.status;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['price'] = this.price;
    data['duration'] = this.duration;
    return data;
  }
}

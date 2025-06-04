class FAQModel {
  bool? success;
  String? message;
  List<FAQItem>? FAQList;

  FAQModel({this.success, this.message, this.FAQList});

  FAQModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      FAQList = <FAQItem>[];
      json['data'].forEach((v) {
        FAQList!.add(FAQItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.FAQList != null) {
      data['data'] = this.FAQList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FAQItem {
  String? sId;
  String? question;
  String? answer;
  String? createdAt;
  String? updatedAt;
  int? iV;

  FAQItem(
      {this.sId,
        this.question,
        this.answer,
        this.createdAt,
        this.updatedAt,
        this.iV});

  FAQItem.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    question = json['question'];
    answer = json['answer'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['question'] = question;
    data['answer'] = answer;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

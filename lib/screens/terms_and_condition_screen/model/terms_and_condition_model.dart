class TermsAndConditionModel {

  Data? data;

  TermsAndConditionModel({ this.data});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {

    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? content;
  int? iV;

  Data({this.sId, this.content, this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    content = json['content'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['content'] = this.content;
    data['__v'] = this.iV;
    return data;
  }
}

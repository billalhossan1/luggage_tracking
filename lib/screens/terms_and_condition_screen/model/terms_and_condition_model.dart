class TermsAndConditionModel {

  Data? data;

  TermsAndConditionModel({ this.data});

  TermsAndConditionModel.fromJson(Map<String, dynamic> json) {

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['content'] = content;
    data['__v'] = iV;
    return data;
  }
}

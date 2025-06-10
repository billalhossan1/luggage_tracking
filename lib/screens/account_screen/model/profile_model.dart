class ProfileModel {
  bool? success;
  String? message;
  Data? data;

  ProfileModel({this.success, this.message, this.data});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  String? sId;
  String? name;
  String? role;
  String? email;
  String? contact;
  bool? isSubscribed;
  String? profile;
  bool? verified;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? address;
  String? city;
  String? country;
  String? dateOfBirth;
  String? gender;
  String? occupation;

  Data(
      {this.sId,
        this.name,
        this.role,
        this.email,
        this.contact,
        this.isSubscribed,
        this.profile,
        this.verified,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.address,
        this.city,
        this.country,
        this.dateOfBirth,
        this.gender,
        this.occupation});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    role = json['role'];
    email = json['email'];
    contact = json['contact'];
    isSubscribed = json['isSubscribed'];
    profile = json['profile'];
    verified = json['verified'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    dateOfBirth = json['dateOfBirth'];
    gender = json['gender'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['role'] = role;
    data['email'] = email;
    data['contact'] = contact;
    data['isSubscribed'] = isSubscribed;
    data['profile'] = profile;
    data['verified'] = verified;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['dateOfBirth'] = dateOfBirth;
    data['gender'] = gender;
    data['occupation'] = occupation;
    return data;
  }
}

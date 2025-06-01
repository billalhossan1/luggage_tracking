class ErrorResponseModel {
  bool? success;
  String? message;
  List<ErrorMessages>? errorMessages;
  String? stack;

  ErrorResponseModel(
      {this.success, this.message, this.errorMessages, this.stack});

  ErrorResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['errorMessages'] != null) {
      errorMessages = <ErrorMessages>[];
      json['errorMessages'].forEach((v) {
        errorMessages!.add(ErrorMessages.fromJson(v));
      });
    }
    stack = json['stack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (errorMessages != null) {
      data['errorMessages'] =
          errorMessages!.map((v) => v.toJson()).toList();
    }
    data['stack'] = stack;
    return data;
  }
}

class ErrorMessages {
  String? path;
  String? message;

  ErrorMessages({this.path, this.message});

  ErrorMessages.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['path'] = path;
    data['message'] = message;
    return data;
  }
}

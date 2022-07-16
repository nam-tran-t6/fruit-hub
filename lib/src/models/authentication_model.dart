class AuthResponseModel {
  final bool isValid;
  final String message;

  AuthResponseModel({
    required this.isValid,
    required this.message,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      isValid: json["isValid"] != null ? json["isValid"] : false,
      message: json["message"] != null ? json["message"] : "",
    );
  }
}

class AuthRequestModel {
  final String name;

  AuthRequestModel({
    required this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
    };
    return map;
  }
}

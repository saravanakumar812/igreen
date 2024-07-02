class GeneralCodeResponse {
  String? message;
  bool? error;
  String? generalCode;
  String? generalId;

  GeneralCodeResponse({this.message, this.error, this.generalCode, this.generalId});

  GeneralCodeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    generalCode = json['generalCode'];
    generalId = json['GeneralId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['generalCode'] = this.generalCode;
    data['GeneralId'] = this.generalId;
    return data;
  }
}
class AttendanceResponseModel {
  String? message;
  bool? error;
  AttendanceResponseData? data;

  AttendanceResponseModel({this.message, this.error, this.data});

  AttendanceResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new AttendanceResponseData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AttendanceResponseData {
  int? id;
  String? status;

  AttendanceResponseData({this.id, this.status});

  AttendanceResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    return data;
  }
}
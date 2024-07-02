class GetSupportResponse {
  String? message;
  bool? error;
  List<GetSupportResponseData>? data;

  GetSupportResponse({this.message, this.error, this.data});

  GetSupportResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetSupportResponseData>[];
      json['data'].forEach((v) {
        data!.add(new GetSupportResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetSupportResponseData {
  int? supportId;
  int? employeeId;
  String? employeeName;
  String? mobile;
  String? messages;

  GetSupportResponseData(
      {this.supportId,
        this.employeeId,
        this.employeeName,
        this.mobile,
        this.messages});

  GetSupportResponseData.fromJson(Map<String, dynamic> json) {
    supportId = json['SupportId'];
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    mobile = json['mobile'];
    messages = json['messages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SupportId'] = this.supportId;
    data['EmployeeId'] = this.employeeId;
    data['EmployeeName'] = this.employeeName;
    data['mobile'] = this.mobile;
    data['messages'] = this.messages;
    return data;
  }
}
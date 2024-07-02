
class EmployeeNameResponseList {
  String? message;
  bool? error;
  List<EmployeeNameResponseData>? data;

  EmployeeNameResponseList({this.message, this.error, this.data});

  EmployeeNameResponseList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <EmployeeNameResponseData>[];
      json['data'].forEach((v) {
        data!.add(new EmployeeNameResponseData.fromJson(v));
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

class EmployeeNameResponseData {
  int? employeeId;
  String? employeeName;

  EmployeeNameResponseData({this.employeeId, this.employeeName});

  EmployeeNameResponseData.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['EmployeeName'] = this.employeeName;
    return data;
  }
}
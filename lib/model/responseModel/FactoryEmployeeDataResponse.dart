class FactoryEmployeeResponse {
  String? message;
  bool? error;
  List<FactoryEmployeeData>? data;

  FactoryEmployeeResponse({this.message, this.error, this.data});

  FactoryEmployeeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FactoryEmployeeData>[];
      json['data'].forEach((v) {
        data!.add(new FactoryEmployeeData.fromJson(v));
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

class FactoryEmployeeData {
  int? employeeId;
  String? employeeName;
  String? department;

  FactoryEmployeeData({this.employeeId, this.employeeName, this.department});

  FactoryEmployeeData.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    department = json['Department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['EmployeeName'] = this.employeeName;
    data['Department'] = this.department;
    return data;
  }
}
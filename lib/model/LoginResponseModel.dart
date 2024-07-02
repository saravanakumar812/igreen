class LoginResponseModel {
  String? message;
  bool? error;
  Data? data;

  LoginResponseModel({this.message, this.error, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? employeeId;
  String? employeeName;
  String? mobileNum;
  int? departmentId;
  String? department;

  Data(
      {this.employeeId,
        this.employeeName,
        this.mobileNum,
        this.departmentId,
        this.department});

  Data.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    mobileNum = json['MobileNum'];
    departmentId = json['DepartmentId'];
    department = json['Department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['EmployeeName'] = this.employeeName;
    data['MobileNum'] = this.mobileNum;
    data['DepartmentId'] = this.departmentId;
    data['Department'] = this.department;
    return data;
  }
}
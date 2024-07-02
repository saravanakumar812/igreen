class GetAllUserResponse {
  String? message;
  bool? error;
  List<GetUserData>? data;

  GetAllUserResponse({this.message, this.error, this.data});

  GetAllUserResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetUserData>[];
      json['data'].forEach((v) {
        data!.add(new GetUserData.fromJson(v));
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

class GetUserData {
  int? employeeId;
  String? employeeName;
  String? mobileNum;
  String? email;
  String? department;
  String? profileImage;

  GetUserData(
      {this.employeeId,
      this.employeeName,
      this.mobileNum,
      this.email,
      this.department,
      this.profileImage});

  GetUserData.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employeeName = json['EmployeeName'];
    mobileNum = json['MobileNum'];
    email = json['Email'];
    department = json['Department'];
    profileImage = json['ProfileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['EmployeeName'] = this.employeeName;
    data['MobileNum'] = this.mobileNum;
    data['Email'] = this.email;
    data['Department'] = this.department;
    data['ProfileImage'] = this.profileImage;
    return data;
  }
}

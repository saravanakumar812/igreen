class FactoryDepartmentResponse {
  String? message;
  bool? error;
  List<FactoryDepartmentData>? data;

  FactoryDepartmentResponse({this.message, this.error, this.data});

  FactoryDepartmentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FactoryDepartmentData>[];
      json['data'].forEach((v) {
        data!.add(new FactoryDepartmentData.fromJson(v));
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

class FactoryDepartmentData {
  int? departmentId;
  String? department;

  FactoryDepartmentData({this.departmentId, this.department});

  FactoryDepartmentData.fromJson(Map<String, dynamic> json) {
    departmentId = json['DepartmentId'];
    department = json['Department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepartmentId'] = this.departmentId;
    data['Department'] = this.department;
    return data;
  }
}
class GetFactoryDepartmentResponse {
  String? message;
  bool? error;
  List<GetFactoryData>? data;

  GetFactoryDepartmentResponse({this.message, this.error, this.data});

  GetFactoryDepartmentResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetFactoryData>[];
      json['data'].forEach((v) {
        data!.add(new GetFactoryData.fromJson(v));
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

class GetFactoryData {
  int? departmentId;
  String? department;

  GetFactoryData({this.departmentId, this.department});

  GetFactoryData.fromJson(Map<String, dynamic> json) {
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

class ProjectViewResponseModel {
  String? message;
  bool? error;
  List<ProjectViewResponseModelData>? data;

  ProjectViewResponseModel({this.message, this.error, this.data});

  ProjectViewResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ProjectViewResponseModelData>[];
      json['data'].forEach((v) {
        data!.add(new ProjectViewResponseModelData.fromJson(v));
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

class ProjectViewResponseModelData {
  String? projectCode;
  dynamic? tenderAmount;
  dynamic? expenseAmount;

  ProjectViewResponseModelData({this.projectCode, this.tenderAmount, this.expenseAmount});

  ProjectViewResponseModelData.fromJson(Map<String, dynamic> json) {
    projectCode = json['projectCode'];
    tenderAmount = json['tenderAmount']  ?? 0;
    expenseAmount = json['expenseAmount'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectCode'] = this.projectCode;
    data['tenderAmount'] = this.tenderAmount;
    data['expenseAmount'] = this.expenseAmount;
    return data;
  }
}
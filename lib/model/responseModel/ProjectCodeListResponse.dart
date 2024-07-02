class ProjectCodeListResponse {
  String? message;
  bool? error;
  List<ProjectListData>? data;

  ProjectCodeListResponse({this.message, this.error, this.data});

  ProjectCodeListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ProjectListData>[];
      json['data'].forEach((v) {
        data!.add(new ProjectListData.fromJson(v));
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

class ProjectListData {
  String? projectCode;

  ProjectListData({this.projectCode});

  ProjectListData.fromJson(Map<String, dynamic> json) {
    projectCode = json['projectCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectCode'] = this.projectCode;
    return data;
  }
}

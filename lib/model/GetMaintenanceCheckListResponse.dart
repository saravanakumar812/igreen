class GetMaintenanceList {
  String? message;
  bool? error;
  List<GetMaintenanceListData>? data;

  GetMaintenanceList({this.message, this.error, this.data});

  GetMaintenanceList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetMaintenanceListData>[];
      json['data'].forEach((v) {
        data!.add(new GetMaintenanceListData.fromJson(v));
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

class GetMaintenanceListData {
  int? id;
  String? checklistName;
  String? checklistStatus;
  String? createdAt;

  GetMaintenanceListData({this.id, this.checklistName, this.checklistStatus, this.createdAt});

  GetMaintenanceListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    checklistName = json['checklist_name'];
    checklistStatus = json['checklist_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['checklist_name'] = this.checklistName;
    data['checklist_status'] = this.checklistStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
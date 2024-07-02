class MaintenanceSummaryList {
  String? message;
  bool? error;
  List<MaintenanceSummaryData>? data;

  MaintenanceSummaryList({this.message, this.error, this.data});

  MaintenanceSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <MaintenanceSummaryData>[];
      json['data'].forEach((v) {
        data!.add(new MaintenanceSummaryData.fromJson(v));
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

class MaintenanceSummaryData {
  int? id;
  String? category;
  String? subCategory;
  String? remark;
  String? checkerName;
  String? daysCount;
  List<MaintenanceList>? maintenanceList;

  MaintenanceSummaryData(
      {this.id,
        this.category,
        this.subCategory,
        this.remark,
        this.checkerName,
        this.daysCount,
        this.maintenanceList});

  MaintenanceSummaryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    subCategory = json['sub_category'];
    remark = json['remark'];
    checkerName = json['checker_name'];
    daysCount = json['days_count'];
    if (json['MaintenanceList'] != null) {
      maintenanceList = <MaintenanceList>[];
      json['MaintenanceList'].forEach((v) {
        maintenanceList!.add(new MaintenanceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['sub_category'] = this.subCategory;
    data['remark'] = this.remark;
    data['checker_name'] = this.checkerName;
    data['days_count'] = this.daysCount;
    if (this.maintenanceList != null) {
      data['MaintenanceList'] =
          this.maintenanceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaintenanceList {
  int? id;
  int? maintenanceChecklistId;
  String? checklistName;
  String? checklistStatus;

  MaintenanceList(
      {this.id,
        this.maintenanceChecklistId,
        this.checklistName,
        this.checklistStatus});

  MaintenanceList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maintenanceChecklistId = json['maintenance_checklist_id'];
    checklistName = json['checklist_name'];
    checklistStatus = json['checklist_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['maintenance_checklist_id'] = this.maintenanceChecklistId;
    data['checklist_name'] = this.checklistName;
    data['checklist_status'] = this.checklistStatus;
    return data;
  }
}
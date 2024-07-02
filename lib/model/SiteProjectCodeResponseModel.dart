class SiteProjectCodeResponseModel {
  String? message;
  bool? error;
  List<SiteProjectCodeResponseModelData>? data;

  SiteProjectCodeResponseModel({this.message, this.error, this.data});

  SiteProjectCodeResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SiteProjectCodeResponseModelData>[];
      json['data'].forEach((v) {
        data!.add(new SiteProjectCodeResponseModelData.fromJson(v));
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

class SiteProjectCodeResponseModelData {
  String? siteProjectId;
  String? lastUpdatedEmployeeID;
  String? lastUpdatedEmployeeName;
  String? projectCode;
  String? department;
  String? date;
  String? lastUpdatedDate;

  SiteProjectCodeResponseModelData(
      {this.siteProjectId,
        this.lastUpdatedEmployeeID,
        this.lastUpdatedEmployeeName,
        this.projectCode,
        this.department,
        this.date,
        this.lastUpdatedDate});

  SiteProjectCodeResponseModelData.fromJson(Map<String, dynamic> json) {
    siteProjectId = json['SiteProjectId'];
    lastUpdatedEmployeeID = json['lastUpdatedEmployeeID'];
    lastUpdatedEmployeeName = json['lastUpdatedEmployeeName'];
    projectCode = json['projectCode'];
    department = json['Department'];
    date = json['Date'];
    lastUpdatedDate = json['lastUpdatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SiteProjectId'] = this.siteProjectId;
    data['lastUpdatedEmployeeID'] = this.lastUpdatedEmployeeID;
    data['lastUpdatedEmployeeName'] = this.lastUpdatedEmployeeName;
    data['projectCode'] = this.projectCode;
    data['Department'] = this.department;
    data['Date'] = this.date;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    return data;
  }
}



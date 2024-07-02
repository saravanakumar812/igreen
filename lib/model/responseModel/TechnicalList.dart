class TechnicalList {
  String? message;
  bool? error;
  List<TechnicalData>? data;

  TechnicalList({this.message, this.error, this.data});

  TechnicalList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TechnicalData>[];
      json['data'].forEach((v) {
        data!.add(new TechnicalData.fromJson(v));
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

class TechnicalData {
  int? projectId;
  String? customerName;
  String? projectName;
  String? projectType;
  String? projectCode;
  String? projectDocuments;
  String? projectDescp;
  String? customerRequiredDate;
  String? dispatchCommittedDate;
  String? technicalUpload;
  String? process;

  TechnicalData(
      {this.projectId,
      this.customerName,
      this.projectName,
      this.projectType,
      this.projectCode,
      this.projectDocuments,
      this.projectDescp,
      this.customerRequiredDate,
      this.dispatchCommittedDate,
      this.technicalUpload,
      this.process});

  TechnicalData.fromJson(Map<String, dynamic> json) {
    projectId = json['ProjectId'];
    customerName = json['CustomerName'];
    projectName = json['ProjectName'];
    projectType = json['ProjectType'];
    projectCode = json['ProjectCode'];
    projectDocuments = json['ProjectDocuments'];
    projectDescp = json['ProjectDescp'];
    customerRequiredDate = json['CustomerRequiredDate'];
    dispatchCommittedDate = json['DispatchCommittedDate'];
    technicalUpload = json['TechnicalUpload'];
    process = json['Process'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectId'] = this.projectId;
    data['CustomerName'] = this.customerName;
    data['ProjectName'] = this.projectName;
    data['ProjectType'] = this.projectType;
    data['ProjectCode'] = this.projectCode;
    data['ProjectDocuments'] = this.projectDocuments;
    data['ProjectDescp'] = this.projectDescp;
    data['CustomerRequiredDate'] = this.customerRequiredDate;
    data['DispatchCommittedDate'] = this.dispatchCommittedDate;
    data['TechnicalUpload'] = this.technicalUpload;
    data['Process'] = this.process;
    return data;
  }
}

class OfficeEmployeeResponse {
  String? message;
  bool? error;
  List<OfficeEmployeeResponseData>? data;

  OfficeEmployeeResponse({this.message, this.error, this.data});

  OfficeEmployeeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <OfficeEmployeeResponseData>[];
      json['data'].forEach((v) {
        data!.add(new OfficeEmployeeResponseData.fromJson(v));
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

class OfficeEmployeeResponseData {
  int? id;
  int? employeeId;
  String? category;
  String? images;
  String? audioFile;
  String? comments;
  int? amount;
  String? spendDate;
  String? addedFrom;
  String? types;
  String? createdAt;

  OfficeEmployeeResponseData(
      {this.id,
        this.employeeId,
        this.category,
        this.images,
        this.audioFile,
        this.comments,
        this.amount,
        this.spendDate,
        this.addedFrom,
        this.types,
        this.createdAt});

  OfficeEmployeeResponseData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeId = json['EmployeeId'];
    category = json['Category'];
    images = json['Images'];
    audioFile = json['audioFile'];
    comments = json['Comments'];
    amount = json['Amount'];
    spendDate = json['SpendDate'];
    addedFrom = json['AddedFrom'];
    types = json['Types'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['EmployeeId'] = this.employeeId;
    data['Category'] = this.category;
    data['Images'] = this.images;
    data['audioFile'] = this.audioFile;
    data['Comments'] = this.comments;
    data['Amount'] = this.amount;
    data['SpendDate'] = this.spendDate;
    data['AddedFrom'] = this.addedFrom;
    data['Types'] = this.types;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}
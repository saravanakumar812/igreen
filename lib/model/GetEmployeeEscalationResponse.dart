class GetEmployeeEscalationModel {
  String? message;
  bool? error;
  List<GetEmployeeEscalationModelData>? data;

  GetEmployeeEscalationModel({this.message, this.error, this.data});

  GetEmployeeEscalationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetEmployeeEscalationModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetEmployeeEscalationModelData.fromJson(v));
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

class GetEmployeeEscalationModelData {
  int? escalationId;
  int? employeeId;
  String? messages;
  String? images;
  String? audioFile;
  int? escalationStatus;
  String? escalationDate;

  GetEmployeeEscalationModelData(
      {this.escalationId,
        this.employeeId,
        this.messages,
        this.images,
        this.audioFile,
        this.escalationStatus,
        this.escalationDate});

  GetEmployeeEscalationModelData.fromJson(Map<String, dynamic> json) {
    escalationId = json['EscalationId'];
    employeeId = json['EmployeeId'];
    messages = json['Messages'];
    images = json['Images'];
    audioFile = json['AudioFile'];
    escalationStatus = json['EscalationStatus'];
    escalationDate = json['EscalationDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EscalationId'] = this.escalationId;
    data['EmployeeId'] = this.employeeId;
    data['Messages'] = this.messages;
    data['Images'] = this.images;
    data['AudioFile'] = this.audioFile;
    data['EscalationStatus'] = this.escalationStatus;
    data['EscalationDate'] = this.escalationDate;
    return data;
  }
}
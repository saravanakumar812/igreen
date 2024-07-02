class EscalationRespondModel {
  String? message;
  bool? error;
  List<EscalationRespondData>? data;

  EscalationRespondModel({this.message, this.error, this.data});

  EscalationRespondModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <EscalationRespondData>[];
      json['data'].forEach((v) {
        data!.add(new EscalationRespondData.fromJson(v));
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

class EscalationRespondData {
  int? employeeId;
  String? employeeMessage;
  String? employeeImage;
  String? employeeAudioFile;
  String? respondMessages;
  String? respondAudioFile;

  EscalationRespondData(
      {this.employeeId,
        this.employeeMessage,
        this.employeeImage,
        this.employeeAudioFile,
        this.respondMessages,
        this.respondAudioFile});

  EscalationRespondData.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    employeeMessage = json['employeeMessage'];
    employeeImage = json['employeeImage'];
    employeeAudioFile = json['employeeAudioFile'];
    respondMessages = json['respondMessages'];
    respondAudioFile = json['respondAudioFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['employeeMessage'] = this.employeeMessage;
    data['employeeImage'] = this.employeeImage;
    data['employeeAudioFile'] = this.employeeAudioFile;
    data['respondMessages'] = this.respondMessages;
    data['respondAudioFile'] = this.respondAudioFile;
    return data;
  }
}
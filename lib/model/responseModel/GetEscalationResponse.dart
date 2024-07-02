class GetEscalationResponse {
  String? message;
  bool? error;
  List<EscalationData>? data;

  GetEscalationResponse({this.message, this.error, this.data});

  GetEscalationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <EscalationData>[];
      json['data'].forEach((v) {
        data!.add(new EscalationData.fromJson(v));
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

class EscalationData {
  int? escalationId;
  int? employeeId;
  String? profileName;
  String? profileImage;
  String? messages;
  String? images;
  String? audioFile;
  int? escalationStatus;
  String? escalationDate;

  EscalationData(
      {this.escalationId,
      this.employeeId,
      this.profileName,
      this.profileImage,
      this.messages,
      this.images,
      this.audioFile,
      this.escalationStatus,
      this.escalationDate});

  EscalationData.fromJson(Map<String, dynamic> json) {
    escalationId = json['EscalationId'];
    employeeId = json['EmployeeId'];
    profileName = json['ProfileName'];
    profileImage = json['ProfileImage'];
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
    data['ProfileName'] = this.profileName;
    data['ProfileImage'] = this.profileImage;
    data['Messages'] = this.messages;
    data['Images'] = this.images;
    data['AudioFile'] = this.audioFile;
    data['EscalationStatus'] = this.escalationStatus;
    data['EscalationDate'] = this.escalationDate;
    return data;
  }
}

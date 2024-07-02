class EscalationPostResponse {
  String? message;
  bool? error;
  List<EscalationValues>? data;

  EscalationPostResponse({this.message, this.error, this.data});

  EscalationPostResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <EscalationValues>[];
      json['data'].forEach((v) {
        data!.add(new EscalationValues.fromJson(v));
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

class EscalationValues {
  int? escalationId;
  int? employeeId;
  String? messages;
  String? images;
  String? audioFile;
  int? escalationStatus;
  String? escalationDate;
  String? respondMessage;
  String? respondAudio;

  EscalationValues(
      {this.escalationId,
        this.employeeId,
        this.messages,
        this.images,
        this.audioFile,
        this.escalationStatus,
        this.escalationDate,
        this.respondMessage,
        this.respondAudio});

  EscalationValues.fromJson(Map<String, dynamic> json) {
    escalationId = json['EscalationId'];
    employeeId = json['EmployeeId'];
    messages = json['Messages'];
    images = json['Images'];
    audioFile = json['AudioFile'];
    escalationStatus = json['EscalationStatus'];
    escalationDate = json['EscalationDate'];
    respondMessage = json['respond_message'];
    respondAudio = json['respond_audio'];
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
    data['respond_message'] = this.respondMessage;
    data['respond_audio'] = this.respondAudio;
    return data;
  }
}
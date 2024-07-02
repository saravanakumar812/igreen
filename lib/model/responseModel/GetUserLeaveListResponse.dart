class GetUserLeaveListResponse {
  String? message;
  bool? error;
  List<UserleaveData>? data;
  List<Count>? count;

  GetUserLeaveListResponse({this.message, this.error, this.data, this.count});

  GetUserLeaveListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <UserleaveData>[];
      json['data'].forEach((v) {
        data!.add(new UserleaveData.fromJson(v));
      });
    }
    if (json['Count'] != null) {
      count = <Count>[];
      json['Count'].forEach((v) {
        count!.add(new Count.fromJson(v));
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
    if (this.count != null) {
      data['Count'] = this.count!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserleaveData {
  int? id;
  String? reason;
  String? explanation;
  String? fromDate;
  String? toDate;
  String? voiceNote;
  int? employeeId;
  int? approved;
  String? rejectVoiceNote;
  String? rejectReason;

  UserleaveData(
      {this.id,
      this.reason,
      this.explanation,
      this.fromDate,
      this.toDate,
      this.voiceNote,
      this.employeeId,
      this.approved,
      this.rejectVoiceNote,
      this.rejectReason});

  UserleaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    explanation = json['explanation'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    voiceNote = json['voice_note'];
    employeeId = json['EmployeeId'];
    approved = json['approved'];
    rejectVoiceNote = json['reject_voice_note'];
    rejectReason = json['reject_reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['explanation'] = this.explanation;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['voice_note'] = this.voiceNote;
    data['EmployeeId'] = this.employeeId;
    data['approved'] = this.approved;
    data['reject_voice_note'] = this.rejectVoiceNote;
    data['reject_reason'] = this.rejectReason;
    return data;
  }
}

class Count {
  int? medicalLeave;
  int? casualLeave;
  int? total;

  Count({this.medicalLeave, this.casualLeave, this.total});

  Count.fromJson(Map<String, dynamic> json) {
    medicalLeave = json['Medical_Leave'];
    casualLeave = json['Casual_Leave'];
    total = json['Total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Medical_Leave'] = this.medicalLeave;
    data['Casual_Leave'] = this.casualLeave;
    data['Total'] = this.total;
    return data;
  }
}

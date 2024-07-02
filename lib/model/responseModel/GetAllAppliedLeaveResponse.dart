class GetAllAppliedLeaveResponse {
  String? message;
  bool? error;
  List<AppliedLeaveData>? data;

  GetAllAppliedLeaveResponse({this.message, this.error, this.data});

  GetAllAppliedLeaveResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <AppliedLeaveData>[];
      json['data'].forEach((v) {
        data!.add(new AppliedLeaveData.fromJson(v));
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

class AppliedLeaveData {
  int? id;
  String? profileName;
  String? profileImage;
  String? reason;
  String? explanation;
  String? fromDate;
  String? toDate;
  String? voiceNote;
  int? employeeId;
  int? approved;
  String? rejectVoiceNote;
  String? rejectReason;

  AppliedLeaveData(
      {this.id,
      this.profileName,
      this.profileImage,
      this.reason,
      this.explanation,
      this.fromDate,
      this.toDate,
      this.voiceNote,
      this.employeeId,
      this.approved,
      this.rejectVoiceNote,
      this.rejectReason});

  AppliedLeaveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileName = json['ProfileName'];
    profileImage = json['ProfileImage'];
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
    data['ProfileName'] = this.profileName;
    data['ProfileImage'] = this.profileImage;
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

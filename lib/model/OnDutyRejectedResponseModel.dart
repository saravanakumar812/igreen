class OnDutyRejectedResponse {
  String? message;
  bool? error;
  List<OnDutyRejectedResponseData>? data;

  OnDutyRejectedResponse({this.message, this.error, this.data});

  OnDutyRejectedResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <OnDutyRejectedResponseData>[];
      json['data'].forEach((v) {
        data!.add(new OnDutyRejectedResponseData.fromJson(v));
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

class OnDutyRejectedResponseData {
  int? id;
  int? employeeId;
  String? startingDate;
  String? endingDate;
  String? remarks;
  String? images;
  String? audioFile;
  String? ondutyStatus;
  String? createdAt;

  OnDutyRejectedResponseData(
      {this.id,
        this.employeeId,
        this.startingDate,
        this.endingDate,
        this.remarks,
        this.images,
        this.audioFile,
        this.ondutyStatus,
        this.createdAt});

  OnDutyRejectedResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeId = json['employee_id'];
    startingDate = json['starting_date'];
    endingDate = json['ending_date'];
    remarks = json['remarks'];
    images = json['images'];
    audioFile = json['audio_file'];
    ondutyStatus = json['onduty_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_id'] = this.employeeId;
    data['starting_date'] = this.startingDate;
    data['ending_date'] = this.endingDate;
    data['remarks'] = this.remarks;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['onduty_status'] = this.ondutyStatus;
    data['created_at'] = this.createdAt;
    return data;
  }
}
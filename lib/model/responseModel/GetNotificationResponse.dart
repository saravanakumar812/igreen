class GetNotificationResponse {
  String? message;
  bool? error;
  List<FundData>? data;

  GetNotificationResponse({this.message, this.error, this.data});

  GetNotificationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FundData>[];
      json['data'].forEach((v) {
        data!.add(new FundData.fromJson(v));
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

class FundData {
  String? profileImage;
  String? userName;
  String? message;
  int? notificationId;
  String? images;
  String? audioFile;
  String? rejectReason;
  String? projectCode;
  int? status;
  int? employeeId;
  String? requestedAmount;
  String? approvedAmount;
  List<UnderFundRequest>? underFundRequest;

  FundData(
      {this.profileImage,
      this.userName,
      this.message,
      this.notificationId,
      this.images,
      this.audioFile,
      this.rejectReason,
      this.projectCode,
      this.status,
      this.employeeId,
      this.requestedAmount,
      this.approvedAmount,
      this.underFundRequest});

  FundData.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'] ?? "";
    userName = json['user_name'];
    message = json['message'];
    notificationId = json['notification_id'];
    images = json['images'];
    audioFile = json['audio_file'];
    rejectReason = json['reject_reason'];
    projectCode = json['project_code'];
    status = json['status'];
    employeeId = json['employee_id'];
    requestedAmount = json['requestedAmount'];
    approvedAmount = json['approvedAmount'];
    if (json['under_fund_request'] != null) {
      underFundRequest = <UnderFundRequest>[];
      json['under_fund_request'].forEach((v) {
        underFundRequest!.add(new UnderFundRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['user_name'] = this.userName;
    data['message'] = this.message;
    data['notification_id'] = this.notificationId;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['reject_reason'] = this.rejectReason;
    data['project_code'] = this.projectCode;
    data['status'] = this.status;
    data['employee_id'] = this.employeeId;
    data['requestedAmount'] = this.requestedAmount;
    data['approvedAmount'] = this.approvedAmount;
    if (this.underFundRequest != null) {
      data['under_fund_request'] =
          this.underFundRequest!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UnderFundRequest {
  int? fundRequestId;
  String? options;
  String? comments;
  dynamic? amount;
  String? Category;

  UnderFundRequest(
      {this.fundRequestId, this.options, this.comments,this.Category, this.amount});

  UnderFundRequest.fromJson(Map<String, dynamic> json) {
    fundRequestId = json['fund_request_id'];
    options = json['options'];
    comments = json['comments'];
    Category = json['Category'] ?? "";
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fund_request_id'] = this.fundRequestId;
    data['options'] = this.options;
    data['comments'] = this.comments;
    data['Category'] = this.Category;
    data['amount'] = this.amount;
    return data;
  }
}

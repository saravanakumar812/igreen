class GetAllFeedbackResponse {
  String? message;
  bool? error;
  List<FeedbackData>? data;

  GetAllFeedbackResponse({this.message, this.error, this.data});

  GetAllFeedbackResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FeedbackData>[];
      json['data'].forEach((v) {
        data!.add(new FeedbackData.fromJson(v));
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

class FeedbackData {
  int? feedbackId;
  int? employeeId;
  String? profileName;
  String? profileImage;
  String? messages;
  String? images;
  String? audioFile;
  int? feedbackStatus;
  String? department;

  FeedbackData(
      {this.feedbackId,
      this.employeeId,
      this.profileName,
      this.profileImage,
      this.messages,
      this.images,
      this.audioFile,
      this.feedbackStatus,
      this.department});

  FeedbackData.fromJson(Map<String, dynamic> json) {
    feedbackId = json['FeedbackId'];
    employeeId = json['EmployeeId'];
    profileName = json['ProfileName'];
    profileImage = json['ProfileImage'];
    messages = json['Messages'];
    images = json['Images'];
    audioFile = json['AudioFile'];
    feedbackStatus = json['FeedbackStatus'];
    department = json['Department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FeedbackId'] = this.feedbackId;
    data['EmployeeId'] = this.employeeId;
    data['ProfileName'] = this.profileName;
    data['ProfileImage'] = this.profileImage;
    data['Messages'] = this.messages;
    data['Images'] = this.images;
    data['AudioFile'] = this.audioFile;
    data['FeedbackStatus'] = this.feedbackStatus;
    data['Department'] = this.department;
    return data;
  }
}

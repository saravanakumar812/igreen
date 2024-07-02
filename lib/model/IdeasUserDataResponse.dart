class IdeasEmployeeResponse {
  String? message;
  bool? error;
  List<IdeasEmployeeResponseData>? data;

  IdeasEmployeeResponse({this.message, this.error, this.data});

  IdeasEmployeeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <IdeasEmployeeResponseData>[];
      json['data'].forEach((v) {
        data!.add(new IdeasEmployeeResponseData.fromJson(v));
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

class IdeasEmployeeResponseData {
  int? id;
  String? ideas;
  String? agreeCount;
  String? employeeName;
  String? images;
  String? audioFile;
  String? createdAt;

  IdeasEmployeeResponseData(
      {this.id,
        this.ideas,
        this.agreeCount,
        this.employeeName,
        this.images,
        this.audioFile,
        this.createdAt});

  IdeasEmployeeResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ideas = json['ideas'];
    agreeCount = json['agree_count'];
    employeeName = json['employee_name'];
    images = json['images'];
    audioFile = json['audio_file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ideas'] = this.ideas;
    data['agree_count'] = this.agreeCount;
    data['employee_name'] = this.employeeName;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['created_at'] = this.createdAt;
    return data;
  }
}
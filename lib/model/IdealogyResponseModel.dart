class IdeaLogyUserResponse {
  String? message;
  bool? error;
  List<IdeaLogyUserResponseData>? data;

  IdeaLogyUserResponse({this.message, this.error, this.data});

  IdeaLogyUserResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <IdeaLogyUserResponseData>[];
      json['data'].forEach((v) {
        data!.add(new IdeaLogyUserResponseData.fromJson(v));
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

class IdeaLogyUserResponseData {
  int? ideasId;
  String? ideas;
  String? agreeCount;
  String? employeeName;
  String? images;
  String? audioFile;
  String? createdAt;

  IdeaLogyUserResponseData(
      {this.ideasId,
        this.ideas,
        this.agreeCount,
        this.employeeName,
        this.images,
        this.audioFile,
        this.createdAt});

  IdeaLogyUserResponseData.fromJson(Map<String, dynamic> json) {
    ideasId = json['ideasId'];
    ideas = json['ideas'];
    agreeCount = json['agree_count'];
    employeeName = json['employee_name'];
    images = json['images'];
    audioFile = json['audio_file'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ideasId'] = this.ideasId;
    data['ideas'] = this.ideas;
    data['agree_count'] = this.agreeCount;
    data['employee_name'] = this.employeeName;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['created_at'] = this.createdAt;
    return data;
  }
}
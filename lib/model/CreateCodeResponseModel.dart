class CreatecodeResponse {
  String? message;
  bool? error;
  String? projectCode;
  String? siteProjectId;


  CreatecodeResponse(
      {this.message, this.error, this.projectCode, this.siteProjectId});

  CreatecodeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    projectCode = json['ProjectCode'];
    siteProjectId = json['SiteProjectId'];
  }

  get data => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['ProjectCode'] = this.projectCode;
    data['SiteProjectId'] = this.siteProjectId;
    return data;
  }
}
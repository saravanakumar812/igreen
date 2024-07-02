class OfficeCategoryResponse {
  String? message;
  bool? error;
  List<OfficeCategoryResponseData>? data;

  OfficeCategoryResponse({this.message, this.error, this.data});

  OfficeCategoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <OfficeCategoryResponseData>[];
      json['data'].forEach((v) {
        data!.add(new OfficeCategoryResponseData.fromJson(v));
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

class OfficeCategoryResponseData {
  int? id;
  String? category;

  OfficeCategoryResponseData({this.id, this.category});

  OfficeCategoryResponseData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Category'] = this.category;
    return data;
  }
}
class TenderDescriptionDropDownResponse {
  String? message;
  bool? error;
  List<TenderDescriptionDropDownResponseData>? data;

  TenderDescriptionDropDownResponse({this.message, this.error, this.data});

  TenderDescriptionDropDownResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TenderDescriptionDropDownResponseData>[];
      json['data'].forEach((v) {
        data!.add(new TenderDescriptionDropDownResponseData.fromJson(v));
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

class TenderDescriptionDropDownResponseData {
  int? id;
  String? descriptions;

  TenderDescriptionDropDownResponseData({this.id, this.descriptions});

  TenderDescriptionDropDownResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    descriptions = json['descriptions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['descriptions'] = this.descriptions;
    return data;
  }
}
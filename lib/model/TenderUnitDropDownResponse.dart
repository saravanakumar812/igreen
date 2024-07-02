class TenderUnitDropdownResponse {
  String? message;
  bool? error;
  List<TenderUnitDropdownResponseData>? data;

  TenderUnitDropdownResponse({this.message, this.error, this.data});

  TenderUnitDropdownResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TenderUnitDropdownResponseData>[];
      json['data'].forEach((v) {
        data!.add(new TenderUnitDropdownResponseData.fromJson(v));
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

class TenderUnitDropdownResponseData {
  int? id;
  String? unit;

  TenderUnitDropdownResponseData({this.id, this.unit});

  TenderUnitDropdownResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['unit'] = this.unit;
    return data;
  }
}
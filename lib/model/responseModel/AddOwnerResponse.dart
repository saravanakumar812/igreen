class AddOwnerResponse {
  String? message;
  bool? error;
  Data? data;

  AddOwnerResponse({this.message, this.error, this.data});

  AddOwnerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? vendorId;

  Data({this.vendorId});

  Data.fromJson(Map<String, dynamic> json) {
    vendorId = json['VendorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VendorId'] = this.vendorId;
    return data;
  }
}
class GetVendorNameResponse {
  String? message;
  bool? error;
  List<GetVendorData>? data;

  GetVendorNameResponse({this.message, this.error, this.data});

  GetVendorNameResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetVendorData>[];
      json['data'].forEach((v) {
        data!.add(new GetVendorData.fromJson(v));
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

class GetVendorData {
  int? vendorId;
  String? vendorCode;
  String? vendorName;
  String? vendorCompany;
  String? vendorAddress;
  String? vendorGST;
  String? vendorMobile;
  String? vendorEmail;
  String? vendorService;

  GetVendorData(
      {this.vendorId,
      this.vendorCode,
      this.vendorName,
      this.vendorCompany,
      this.vendorAddress,
      this.vendorGST,
      this.vendorMobile,
      this.vendorEmail,
      this.vendorService});

  GetVendorData.fromJson(Map<String, dynamic> json) {
    vendorId = json['VendorId'];
    vendorCode = json['VendorCode'];
    vendorName = json['VendorName'];
    vendorCompany = json['VendorCompany'];
    vendorAddress = json['VendorAddress'];
    vendorGST = json['VendorGST'];
    vendorMobile = json['VendorMobile'];
    vendorEmail = json['VendorEmail'];
    vendorService = json['VendorService'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VendorId'] = this.vendorId;
    data['VendorCode'] = this.vendorCode;
    data['VendorName'] = this.vendorName;
    data['VendorCompany'] = this.vendorCompany;
    data['VendorAddress'] = this.vendorAddress;
    data['VendorGST'] = this.vendorGST;
    data['VendorMobile'] = this.vendorMobile;
    data['VendorEmail'] = this.vendorEmail;
    data['VendorService'] = this.vendorService;
    return data;
  }
}

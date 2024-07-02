class GetOwnerResponse {
  String? message;
  bool? error;
  List<GetOwnerData>? data;

  GetOwnerResponse({this.message, this.error, this.data});

  GetOwnerResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetOwnerData>[];
      json['data'].forEach((v) {
        data!.add(new GetOwnerData.fromJson(v));
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

class GetOwnerData {
  int? vendorId;
  String? ownerName;
  int? ownerContact;
  String? registerationNumber;
  String? vechicalDetails;

  GetOwnerData(
      {this.vendorId,
        this.ownerName,
        this.ownerContact,
        this.registerationNumber,
        this.vechicalDetails});

  GetOwnerData.fromJson(Map<String, dynamic> json) {
    vendorId = json['VendorId'];
    ownerName = json['owner_name'];
    ownerContact = json['owner_contact'];
    registerationNumber = json['registeration_number'];
    vechicalDetails = json['vechical_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['VendorId'] = this.vendorId;
    data['owner_name'] = this.ownerName;
    data['owner_contact'] = this.ownerContact;
    data['registeration_number'] = this.registerationNumber;
    data['vechical_details'] = this.vechicalDetails;
    return data;
  }
}
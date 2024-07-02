class GetSubCategoryDropdownList {
  String? message;
  bool? error;
  List<GetSubCategoryDropdownData>? data;

  GetSubCategoryDropdownList({this.message, this.error, this.data});

  GetSubCategoryDropdownList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetSubCategoryDropdownData>[];
      json['data'].forEach((v) {
        data!.add(new GetSubCategoryDropdownData.fromJson(v));
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

class GetSubCategoryDropdownData {
  String? id;
  String? subCategoryName;
  String? subCategoryImages;
  String? mechineDetails;
  String? vehiclesDetails;
  String? createdAt;

  GetSubCategoryDropdownData(
      {this.id,
        this.subCategoryName,
        this.subCategoryImages,
        this.mechineDetails,
        this.vehiclesDetails,
        this.createdAt});

  GetSubCategoryDropdownData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subCategoryName = json['sub_category_name'];
    subCategoryImages = json['sub_category_images'];
    mechineDetails = json['mechine_details'];
    vehiclesDetails = json['vehicles_details'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_category_name'] = this.subCategoryName;
    data['sub_category_images'] = this.subCategoryImages;
    data['mechine_details'] = this.mechineDetails;
    data['vehicles_details'] = this.vehiclesDetails;
    data['created_at'] = this.createdAt;
    return data;
  }
}
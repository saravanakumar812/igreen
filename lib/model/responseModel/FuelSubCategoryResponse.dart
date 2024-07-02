class FuelSubCategoryResponse {
  String? message;
  bool? error;
  List<FuelSubOneData>? data;

  FuelSubCategoryResponse({this.message, this.error, this.data});

  FuelSubCategoryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FuelSubOneData>[];
      json['data'].forEach((v) {
        data!.add(new FuelSubOneData.fromJson(v));
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

class FuelSubOneData {
  int? sub1CategoryId;
  int? expenseCategoryId;
  String? sub1CategoryName;
  int? isSubCategory;
  String? sub1CategoryImage;
  String? types;

  FuelSubOneData({this.sub1CategoryId,
    this.expenseCategoryId,
    this.sub1CategoryName,
    this.isSubCategory,
    this.sub1CategoryImage,
    this.types});

  FuelSubOneData.fromJson(Map<String, dynamic> json) {
    sub1CategoryId = json['Sub1CategoryId'];
    expenseCategoryId = json['ExpenseCategoryId'];
    sub1CategoryName = json['Sub1CategoryName'];
    isSubCategory = json['isSubCategory'];
    sub1CategoryImage = json['Sub1CategoryImage'];
    types = json['types'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sub1CategoryId'] = this.sub1CategoryId;
    data['ExpenseCategoryId'] = this.expenseCategoryId;
    data['Sub1CategoryName'] = this.sub1CategoryName;
    data['isSubCategory'] = this.isSubCategory;
    data['Sub1CategoryImage'] = this.sub1CategoryImage;
    data['types'] = this.types;
    return data;
  }
}

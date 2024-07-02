class FetchSubcategoryTwoResponse {
  String? message;
  bool? error;
  List<SubcategoryTwoData>? data;

  FetchSubcategoryTwoResponse({this.message, this.error, this.data});

  FetchSubcategoryTwoResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SubcategoryTwoData>[];
      json['data'].forEach((v) {
        data!.add(new SubcategoryTwoData.fromJson(v));
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

class SubcategoryTwoData {
  dynamic? sub2CategoryId;
  int? expenseCategoryId;
  dynamic? sub1CategoryId;
  String? sub2CategoryName;
  String? sub2CategoryImage;
  int? isSubCategory;

  SubcategoryTwoData(
      {this.sub2CategoryId,
      this.expenseCategoryId,
      this.sub1CategoryId,
      this.sub2CategoryName,
      this.sub2CategoryImage,
      this.isSubCategory});

  SubcategoryTwoData.fromJson(Map<String, dynamic> json) {
    sub2CategoryId = json['Sub2CategoryId'];
    expenseCategoryId = json['ExpenseCategoryId'];
    sub1CategoryId = json['Sub1CategoryId'];
    sub2CategoryName = json['Sub2CategoryName'];
    sub2CategoryImage = json['Sub2CategoryImage'];
    isSubCategory = json['isSubCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sub2CategoryId'] = this.sub2CategoryId;
    data['ExpenseCategoryId'] = this.expenseCategoryId;
    data['Sub1CategoryId'] = this.sub1CategoryId;
    data['Sub2CategoryName'] = this.sub2CategoryName;
    data['Sub2CategoryImage'] = this.sub2CategoryImage;
    data['isSubCategory'] = this.isSubCategory;
    return data;
  }
}

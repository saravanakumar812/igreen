class FetchSubcategoryFourResponse {
  String? message;
  bool? error;
  List<SubcategoryFourData>? data;

  FetchSubcategoryFourResponse({this.message, this.error, this.data});

  FetchSubcategoryFourResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SubcategoryFourData>[];
      json['data'].forEach((v) {
        data!.add(new SubcategoryFourData.fromJson(v));
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

class SubcategoryFourData {
  int? sub4CategoryId;
  int? sub3CategoryId;
  String? sub4CategoryName;
  String? sub4CategoryImage;
  int? isSubCategory;

  SubcategoryFourData(
      {this.sub4CategoryId,
      this.sub3CategoryId,
      this.sub4CategoryName,
      this.sub4CategoryImage,
      this.isSubCategory});

  SubcategoryFourData.fromJson(Map<String, dynamic> json) {
    sub4CategoryId = json['Sub4CategoryId'];
    sub3CategoryId = json['Sub3CategoryId'];
    sub4CategoryName = json['Sub4CategoryName'];
    sub4CategoryImage = json['Sub4CategoryImage'];
    isSubCategory = json['isSubCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sub4CategoryId'] = this.sub4CategoryId;
    data['Sub3CategoryId'] = this.sub3CategoryId;
    data['Sub4CategoryName'] = this.sub4CategoryName;
    data['Sub4CategoryImage'] = this.sub4CategoryImage;
    data['isSubCategory'] = this.isSubCategory;
    return data;
  }
}

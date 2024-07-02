class FetchSubcategoryThreeResponse {
  String? message;
  bool? error;
  List<SubcategoryThreeData>? data;

  FetchSubcategoryThreeResponse({this.message, this.error, this.data});

  FetchSubcategoryThreeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SubcategoryThreeData>[];
      json['data'].forEach((v) {
        data!.add(new SubcategoryThreeData.fromJson(v));
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

class SubcategoryThreeData {
  int? sub3CategoryId;
  int? sub2CategoryId;
  String? sub3CategoryName;
  String? sub3CategoryImage;
  int? isSubCategory;

  SubcategoryThreeData(
      {this.sub3CategoryId,
      this.sub2CategoryId,
      this.sub3CategoryName,
      this.sub3CategoryImage,
      this.isSubCategory});

  SubcategoryThreeData.fromJson(Map<String, dynamic> json) {
    sub3CategoryId = json['Sub3CategoryId'];
    sub2CategoryId = json['Sub2CategoryId'];
    sub3CategoryName = json['Sub3CategoryName'];
    sub3CategoryImage = json['Sub3CategoryImage'];
    isSubCategory = json['isSubCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Sub3CategoryId'] = this.sub3CategoryId;
    data['Sub2CategoryId'] = this.sub2CategoryId;
    data['Sub3CategoryName'] = this.sub3CategoryName;
    data['Sub3CategoryImage'] = this.sub3CategoryImage;
    data['isSubCategory'] = this.isSubCategory;
    return data;
  }
}

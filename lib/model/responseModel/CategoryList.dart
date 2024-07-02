class CategoryList {
  String? message;
  bool? error;
  List<CategoryListData>? data;

  CategoryList({this.message, this.error, this.data});

  CategoryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CategoryListData>[];
      json['data'].forEach((v) {
        data!.add(new CategoryListData.fromJson(v));
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

class CategoryListData {
  int? expenseCategoryId;
  String? expenseCategoryName;
  int? isSubCategory;
  String? expenseCategoryImage;

  CategoryListData(
      {this.expenseCategoryId,
        this.expenseCategoryName,
        this.isSubCategory,
        this.expenseCategoryImage});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    expenseCategoryId = json['ExpenseCategoryId'];
    expenseCategoryName = json['ExpenseCategoryName'];
    isSubCategory = json['isSubCategory'];
    expenseCategoryImage = json['ExpenseCategoryImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ExpenseCategoryId'] = this.expenseCategoryId;
    data['ExpenseCategoryName'] = this.expenseCategoryName;
    data['isSubCategory'] = this.isSubCategory;
    data['ExpenseCategoryImage'] = this.expenseCategoryImage;
    return data;
  }
}
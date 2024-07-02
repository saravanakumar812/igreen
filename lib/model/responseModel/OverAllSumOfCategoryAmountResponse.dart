class OverAllSumOfCategoryAmountResponse {
  String? message;
  bool? error;
  List<CategoryAmount>? data;

  OverAllSumOfCategoryAmountResponse({this.message, this.error, this.data});

  OverAllSumOfCategoryAmountResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CategoryAmount>[];
      json['data'].forEach((v) {
        data!.add(new CategoryAmount.fromJson(v));
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

class CategoryAmount {
  String? mainCategory;
  String? totalExpenseAmount;

  CategoryAmount({this.mainCategory, this.totalExpenseAmount});

  CategoryAmount.fromJson(Map<String, dynamic> json) {
    mainCategory = json['mainCategory'];
    totalExpenseAmount = json['totalExpenseAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mainCategory'] = this.mainCategory;
    data['totalExpenseAmount'] = this.totalExpenseAmount;
    return data;
  }
}
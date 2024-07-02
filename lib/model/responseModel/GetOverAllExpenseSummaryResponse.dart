class GetOverAllExpenseSummaryResponse {
  String? message;
  bool? error;
  List<GraphData>? data;

  GetOverAllExpenseSummaryResponse({this.message, this.error, this.data});

  GetOverAllExpenseSummaryResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GraphData>[];
      json['data'].forEach((v) {
        data!.add(new GraphData.fromJson(v));
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

class  GraphData {
  int? id;
  int? employeeId;
  String? senderName;
  String? projectName;
  String? dates;
  String? mainCategory;
  String? subCategory;
  String? descriptions;
  int? expenseAmount;
  int? creditAmount;
  int? balanceAmount;
  int? mainCategoryId;
  int? expenseStatus;

  GraphData(
      {this.id,
      this.employeeId,
      this.senderName,
      this.projectName,
      this.dates,
      this.mainCategory,
      this.subCategory,
      this.descriptions,
      this.expenseAmount,
      this.creditAmount,
      this.balanceAmount,
      this.mainCategoryId,
      this.expenseStatus});

  GraphData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    employeeId = json['employeeId'];
    senderName = json['senderName'];
    projectName = json['projectName'];
    dates = json['dates'];
    mainCategory = json['mainCategory'];
    subCategory = json['subCategory'];
    descriptions = json['Descriptions'];
    expenseAmount = json['expenseAmount'];
    creditAmount = json['creditAmount'];
    balanceAmount = json['balanceAmount'];
    mainCategoryId = json['mainCategoryId'];
    expenseStatus = json['ExpenseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['employeeId'] = this.employeeId;
    data['senderName'] = this.senderName;
    data['projectName'] = this.projectName;
    data['dates'] = this.dates;
    data['mainCategory'] = this.mainCategory;
    data['subCategory'] = this.subCategory;
    data['Descriptions'] = this.descriptions;
    data['expenseAmount'] = this.expenseAmount;
    data['creditAmount'] = this.creditAmount;
    data['balanceAmount'] = this.balanceAmount;
    data['mainCategoryId'] = this.mainCategoryId;
    data['ExpenseStatus'] = this.expenseStatus;
    return data;
  }
}

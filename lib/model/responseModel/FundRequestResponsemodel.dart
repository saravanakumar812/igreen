class RequestList {
  String? options;
  String? Category;
  int? amount;
  String? comments;

  RequestList({this.options, this.amount});

  RequestList.fromJson(Map<String, dynamic> json) {
    options = json['options'];
    amount = json['Amount'] ?? 0;
    comments = json['comments'] ?? "";
    Category = json['Category'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['options'] = this.options;
    data['Amount'] = this.amount;
    data['comments'] = this.comments;
    data['Category'] = this.Category;
    return data;
  }
}
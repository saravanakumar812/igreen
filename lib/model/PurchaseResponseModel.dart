class InsertPurchaseData {
  String? message;
  bool? error;
  String? data;

  InsertPurchaseData({this.message, this.error, this.data});

  InsertPurchaseData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['data'] = this.data;
    return data;
  }
}
class GetGreenThankResponse {
  String? message;
  bool? error;
  List<GetGreenThankResponseData>? data;

  GetGreenThankResponse({this.message, this.error, this.data});

  GetGreenThankResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetGreenThankResponseData>[];
      json['data'].forEach((v) {
        data!.add(new GetGreenThankResponseData.fromJson(v));
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

class GetGreenThankResponseData {
  int? id;
  int? amount;
  String? remarks;
  String? createdAt;

  GetGreenThankResponseData({this.id, this.amount, this.remarks, this.createdAt});

  GetGreenThankResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    remarks = json['remarks'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['remarks'] = this.remarks;
    data['created_at'] = this.createdAt;
    return data;
  }
}
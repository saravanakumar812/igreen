class FlowOfBillDropdownResponse {
  String? message;
  bool? error;
  List<FlowOfBillDropdownResponseData>? data;

  FlowOfBillDropdownResponse({this.message, this.error, this.data});

  FlowOfBillDropdownResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FlowOfBillDropdownResponseData>[];
      json['data'].forEach((v) {
        data!.add(new FlowOfBillDropdownResponseData.fromJson(v));
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

class FlowOfBillDropdownResponseData {
  String? flowOfBill;

  FlowOfBillDropdownResponseData({this.flowOfBill});

  FlowOfBillDropdownResponseData.fromJson(Map<String, dynamic> json) {
    flowOfBill = json['flowOfBill'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flowOfBill'] = this.flowOfBill;
    return data;
  }
}
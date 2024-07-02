class GetBalanceResponse {
  String? message;
  bool? error;
  DataBalance? data;

  GetBalanceResponse({this.message, this.error, this.data});

  GetBalanceResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new DataBalance.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataBalance {
  String? descriptions;
  dynamic? availableBalance;
  dynamic? EmployeeBalance;

  DataBalance({this.descriptions, this.availableBalance , this.EmployeeBalance});

  DataBalance.fromJson(Map<String, dynamic> json) {
    descriptions = json['Descriptions'];
    availableBalance = json['available_balance'] ?? "0";
    EmployeeBalance = json['EmployeeBalance'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Descriptions'] = this.descriptions;
    data['AvailableBalance'] = this.availableBalance;
    data['EmployeeBalance'] = this.EmployeeBalance;
    return data;
  }
}

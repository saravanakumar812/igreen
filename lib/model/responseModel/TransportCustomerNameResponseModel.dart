class TransportCustomerNameList {
  String? message;
  bool? error;
  List<TransportCustomerNameData>? data;

  TransportCustomerNameList({this.message, this.error, this.data});

  TransportCustomerNameList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TransportCustomerNameData>[];
      json['data'].forEach((v) {
        data!.add(new TransportCustomerNameData.fromJson(v));
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

class TransportCustomerNameData {
  int? id;
  String? customerName;
  int? customerContact;
  String? createdAt;

  TransportCustomerNameData({this.id, this.customerName, this.customerContact, this.createdAt});

  TransportCustomerNameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerContact = json['customer_contact'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_contact'] = this.customerContact;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class PurchaseSummaryList {
  String? message;
  bool? error;
  List<PurchaseData>? data;

  PurchaseSummaryList({this.message, this.error, this.data});

  PurchaseSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <PurchaseData>[];
      json['data'].forEach((v) {
        data!.add(new PurchaseData.fromJson(v));
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

class PurchaseData {
  String? category1;
  String? category2;
  String? category3;
  String? category4;
  String? category5;
  String? fromDate;
  String? toDate;
  String? startingKM;
  String? endKM;
  String? tollCharges;
  String? amount;
  String? comments;
  String? ticketCharges;
  String? driverTips;
  String? expenseDate;

  PurchaseData(
      {this.category1,
        this.category2,
        this.category3,
        this.category4,
        this.category5,
        this.fromDate,
        this.toDate,
        this.startingKM,
        this.endKM,
        this.tollCharges,
        this.amount,
        this.comments,
        this.ticketCharges,
        this.driverTips,
        this.expenseDate});

  PurchaseData.fromJson(Map<String, dynamic> json) {
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    category4 = json['category4'];
    category5 = json['category5'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    startingKM = json['starting_KM'];
    endKM = json['end_KM'];
    tollCharges = json['toll_charges'];
    amount = json['amount'];
    comments = json['comments'];
    ticketCharges = json['ticket_charges'];
    driverTips = json['driver_tips'];
    expenseDate = json['expenseDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['category4'] = this.category4;
    data['category5'] = this.category5;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['starting_KM'] = this.startingKM;
    data['end_KM'] = this.endKM;
    data['toll_charges'] = this.tollCharges;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['ticket_charges'] = this.ticketCharges;
    data['driver_tips'] = this.driverTips;
    data['expenseDate'] = this.expenseDate;
    return data;
  }
}
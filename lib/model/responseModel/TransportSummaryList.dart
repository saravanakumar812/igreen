class TransportSummaryList {
  String? message;
  bool? error;
  List<TransportData>? data;

  TransportSummaryList({this.message, this.error, this.data});

  TransportSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TransportData>[];
      json['data'].forEach((v) {
        data!.add(new TransportData.fromJson(v));
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

class TransportData {
  String? id;
  String? category1;
  String? category2;
  String? fromDate;
  String? toDate;
  String? tripCost;
  String? comment;
  String? expenseDate;
  String? goodsName;
  String? customerName;
  String? images;
  String? audioFile;
  String? dcUpload;
  String? eWayBill;
  String? invoiceBill;
  String? expenseStatus;

  TransportData(
      {this.id,
        this.category1,
        this.category2,
        this.fromDate,
        this.toDate,
        this.tripCost,
        this.comment,
        this.expenseDate,
        this.goodsName,
        this.customerName,
        this.images,
        this.audioFile,
        this.dcUpload,
        this.eWayBill,
        this.invoiceBill,
        this.expenseStatus});

  TransportData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    tripCost = json['trip_cost'];
    comment = json['comment'];
    expenseDate = json['expenseDate'];
    goodsName = json['GoodsName'];
    customerName = json['CustomerName'];
    images = json['images'];
    audioFile = json['audio_file'];
    dcUpload = json['dc_upload'];
    eWayBill = json['e_way_bill'];
    invoiceBill = json['invoice_bill'];
    expenseStatus = json['ExpenseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['trip_cost'] = this.tripCost;
    data['comment'] = this.comment;
    data['expenseDate'] = this.expenseDate;
    data['GoodsName'] = this.goodsName;
    data['CustomerName'] = this.customerName;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['dc_upload'] = this.dcUpload;
    data['e_way_bill'] = this.eWayBill;
    data['invoice_bill'] = this.invoiceBill;
    data['ExpenseStatus'] = this.expenseStatus;
    return data;
  }
}
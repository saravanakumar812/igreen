class GetPurchaseResponse {
  String? message;
  bool? error;
  List<GetPurchaseData>? data;

  GetPurchaseResponse({this.message, this.error, this.data});

  GetPurchaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetPurchaseData>[];
      json['data'].forEach((v) {
        data!.add(new GetPurchaseData.fromJson(v));
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

class GetPurchaseData {
  String? id;
  String? category1;
  String? category2;
  String? category3;
  String? amount;
  String? comments;
  String? materialName;
  String? unit;
  String? expenseDate;
  String? currentlyPaidAmount;
  String? balanceAmount;
  String? images;
  String? audioFile;
  String? owner;
  String? expenseStatus;

  GetPurchaseData(
      {this.id,
        this.category1,
        this.category2,
        this.category3,
        this.amount,
        this.comments,
        this.materialName,
        this.unit,
        this.expenseDate,
        this.currentlyPaidAmount,
        this.balanceAmount,
        this.images,
        this.audioFile,
        this.expenseStatus,
        this.owner});

  GetPurchaseData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    amount = json['amount'];
    comments = json['comments'];
    materialName = json['material_name'];
    unit = json['unit'];
    expenseDate = json['expenseDate'];
    currentlyPaidAmount = json['currently_paid_amount'];
    balanceAmount = json['balance_amount'];
    expenseStatus = json['ExpenseStatus'];
    images = json['images'];
    audioFile = json['audio_file'];
    owner = json['owner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['amount'] = this.amount;
    data['ExpenseStatus'] = this.expenseStatus;
    data['comments'] = this.comments;
    data['material_name'] = this.materialName;
    data['unit'] = this.unit;
    data['expenseDate'] = this.expenseDate;
    data['currently_paid_amount'] = this.currentlyPaidAmount;
    data['balance_amount'] = this.balanceAmount;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['owner'] = this.owner;
    return data;
  }
}
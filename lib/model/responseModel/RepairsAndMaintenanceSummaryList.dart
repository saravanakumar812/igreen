class RepairsAndMaintenanceSummaryList {
  String? message;
  bool? error;
  List<RepairsAndMaintenanceData>? data;

  RepairsAndMaintenanceSummaryList({this.message, this.error, this.data});

  RepairsAndMaintenanceSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <RepairsAndMaintenanceData>[];
      json['data'].forEach((v) {
        data!.add(new RepairsAndMaintenanceData.fromJson(v));
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

class RepairsAndMaintenanceData {
  String? id;
  String? category1;
  String? category2;
  String? nextDueDate;
  String? amount;
  String? comments;
  String? expenseDate;
  String? currentlyPaidAmount;
  String? balanceAmount;
  String? images;
  String? audioFile;
  String? category3;
  String? expenseStatus;

  RepairsAndMaintenanceData(
      {this.id,
        this.category1,
        this.category2,
        this.nextDueDate,
        this.amount,
        this.comments,
        this.expenseDate,
        this.currentlyPaidAmount,
        this.balanceAmount,
        this.images,
        this.expenseStatus,
        this.audioFile,
        this.category3});

  RepairsAndMaintenanceData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    nextDueDate = json['next_due_date'];
    amount = json['amount'];
    comments = json['comments'];
    expenseStatus = json['ExpenseStatus'];
    expenseDate = json['expenseDate'];
    currentlyPaidAmount = json['currently_paid_amount'];
    balanceAmount = json['balance_amount'];
    images = json['images'];
    audioFile = json['audio_file'];
    category3 = json['category3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['next_due_date'] = this.nextDueDate;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['expenseDate'] = this.expenseDate;
    data['currently_paid_amount'] = this.currentlyPaidAmount;
    data['ExpenseStatus'] = this.expenseStatus;
    data['balance_amount'] = this.balanceAmount;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['category3'] = this.category3;
    return data;
  }
}
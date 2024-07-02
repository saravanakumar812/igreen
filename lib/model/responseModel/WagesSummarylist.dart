class WagesSummaryList {
  String? message;
  bool? error;
  List<WagesData>? data;

  WagesSummaryList({this.message, this.error, this.data});

  WagesSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <WagesData>[];
      json['data'].forEach((v) {
        data!.add(new WagesData.fromJson(v));
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

class WagesData {
  int? wagesId;
  String? category1;
  String? category2;
  String? category3;
  String? category4;
  String? category5;
  String? noOfPeople;
  String? bettaCharges;
  String? wagesCharges;
  String? comments;
  int? expenseAmount;
  String? expenseDate;
  String? expenseStatus;
  String? images;
  String? audioFile;
  int? currentlyPaidAmount;
  int? balance;
  List<WagesEmployee>? wagesEmployee;

  WagesData(
      {this.wagesId,
        this.category1,
        this.category2,
        this.category3,
        this.category4,
        this.category5,
        this.noOfPeople,
        this.bettaCharges,
        this.wagesCharges,
        this.comments,
        this.expenseAmount,
        this.expenseDate,
        this.expenseStatus,
        this.images,
        this.audioFile,
        this.currentlyPaidAmount,
        this.balance,
        this.wagesEmployee});

  WagesData.fromJson(Map<String, dynamic> json) {
    wagesId = json['wagesId'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    category4 = json['category4'];
    category5 = json['category5'];
    noOfPeople = json['no_of_people'];
    bettaCharges = json['betta_charges'];
    wagesCharges = json['wages_charges'];
    comments = json['comments'];
    expenseAmount = json['ExpenseAmount'];
    expenseDate = json['expenseDate'];
    expenseStatus = json['ExpenseStatus'];
    images = json['images'];
    audioFile = json['audio_file'];
    currentlyPaidAmount = json['currently_paid_amount'];
    balance = json['balance'];
    if (json['wagesEmployee'] != null) {
      wagesEmployee = <WagesEmployee>[];
      json['wagesEmployee'].forEach((v) {
        wagesEmployee!.add(new WagesEmployee.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wagesId'] = this.wagesId;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['category4'] = this.category4;
    data['category5'] = this.category5;
    data['no_of_people'] = this.noOfPeople;
    data['betta_charges'] = this.bettaCharges;
    data['wages_charges'] = this.wagesCharges;
    data['comments'] = this.comments;
    data['ExpenseAmount'] = this.expenseAmount;
    data['expenseDate'] = this.expenseDate;
    data['ExpenseStatus'] = this.expenseStatus;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['currently_paid_amount'] = this.currentlyPaidAmount;
    data['balance'] = this.balance;
    if (this.wagesEmployee != null) {
      data['wagesEmployee'] =
          this.wagesEmployee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WagesEmployee {
  int? wagesEmployeeId;
  int? wagesId;
  String? employeeName;
  int? amount;
  String? fingerPrint;
  String? photo;
  int? contactNumber;

  WagesEmployee(
      {this.wagesEmployeeId,
        this.wagesId,
        this.employeeName,
        this.amount,
        this.fingerPrint,
        this.photo,
        this.contactNumber});

  WagesEmployee.fromJson(Map<String, dynamic> json) {
    wagesEmployeeId = json['wagesEmployeeId'];
    wagesId = json['wages_id'];
    employeeName = json['employee_name'];
    amount = json['amount'];
    fingerPrint = json['finger_print'];
    photo = json['photo'];
    contactNumber = json['contact_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wagesEmployeeId'] = this.wagesEmployeeId;
    data['wages_id'] = this.wagesId;
    data['employee_name'] = this.employeeName;
    data['amount'] = this.amount;
    data['finger_print'] = this.fingerPrint;
    data['photo'] = this.photo;
    data['contact_number'] = this.contactNumber;
    return data;
  }
}
class GeneralSummaryList {
  String? message;
  bool? error;
  List<GeneralData>? data;

  GeneralSummaryList({this.message, this.error, this.data});

  GeneralSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GeneralData>[];
      json['data'].forEach((v) {
        data!.add(new GeneralData.fromJson(v));
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

class GeneralData {
  String? id;
  String? category1;
  String? category2;
  String? category3;
  String? amount;
  String? comments;
  String? expenseDate;
  String? images;
  String? audioFile;
  String? expenseStatus;
  String? category4;

  GeneralData(
      {this.id,
        this.category1,
        this.category2,
        this.category3,
        this.amount,
        this.comments,
        this.expenseDate,
        this.images,
        this.audioFile,
        this.expenseStatus,
        this.category4});

  GeneralData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    amount = json['amount'];
    comments = json['comments'];
    expenseDate = json['expenseDate'];
    images = json['images'];
    audioFile = json['audio_file'];
    expenseStatus = json['ExpenseStatus'];
    category4 = json['category4'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['expenseDate'] = this.expenseDate;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['ExpenseStatus'] = this.expenseStatus;
    data['category4'] = this.category4;
    return data;
  }
}
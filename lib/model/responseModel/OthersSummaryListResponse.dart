class OthersSummaryListResponse {
  String? message;
  bool? error;
  List<OthersData>? data;

  OthersSummaryListResponse({this.message, this.error, this.data});

  OthersSummaryListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <OthersData>[];
      json['data'].forEach((v) {
        data!.add(new OthersData.fromJson(v));
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

class OthersData {
  String? id;
  String? amount;
  String? comments;
  String? category;
  String? category1;
  String? category2;
  String? expenseDate;
  String? images;
  String? audioFile;
  String? expenseStatus;

  OthersData(
      {this.id,
        this.amount,
        this.comments,
        this.category,
        this.category1,
        this.category2,
        this.expenseDate,
        this.images,
        this.audioFile,
        this.expenseStatus});

  OthersData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    amount = json['amount'];
    comments = json['comments'];
    category = json['category'];
    category1 = json['category1'];
    category2 = json['category2'];
    expenseDate = json['expenseDate'];
    images = json['images'];
    audioFile = json['audio_file'];
    expenseStatus = json['ExpenseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['category'] = this.category;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['expenseDate'] = this.expenseDate;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['ExpenseStatus'] = this.expenseStatus;
    return data;
  }
}
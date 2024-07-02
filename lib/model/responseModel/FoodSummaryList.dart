class FoodSummaryList {
  String? message;
  bool? error;
  List<FoodData>? data;

  FoodSummaryList({this.message, this.error, this.data});

  FoodSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FoodData>[];
      json['data'].forEach((v) {
        data!.add(new FoodData.fromJson(v));
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

class FoodData {
  String? id;
  String? category1;
  String? category2;
  String? noOfPeople;
  String? rate;
  String? totalAmount;
  String? comments;
  String? expenseDate;
  String? expenseStatus;
  String? images;
  String? audioFile;

  FoodData(
      {this.id,
        this.category1,
        this.category2,
        this.noOfPeople,
        this.rate,
        this.totalAmount,
        this.comments,
        this.expenseDate,
        this.expenseStatus,
        this.images,
        this.audioFile});

  FoodData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    noOfPeople = json['no_of_people'];
    rate = json['rate'];
    totalAmount = json['total_amount'];
    comments = json['comments'];
    expenseDate = json['expenseDate'];
    expenseStatus = json['ExpenseStatus'];
    images = json['images'];
    audioFile = json['audio_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['no_of_people'] = this.noOfPeople;
    data['rate'] = this.rate;
    data['total_amount'] = this.totalAmount;
    data['comments'] = this.comments;
    data['expenseDate'] = this.expenseDate;
    data['ExpenseStatus'] = this.expenseStatus;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    return data;
  }
}
class UtilizationSummaryList {
  String? message;
  bool? error;
  List<UtilizationData>? data;

  UtilizationSummaryList({this.message, this.error, this.data});

  UtilizationSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <UtilizationData>[];
      json['data'].forEach((v) {
        data!.add(new UtilizationData.fromJson(v));
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

class UtilizationData {
  String? id;
  String? category1;
  String? category2;
  String? category3;
  String? quantity;
  String? comments;
  String? images;
  String? audioFile;
  String? expenseStatus;
  String? quantityType;

  UtilizationData(
      {this.id,
        this.category1,
        this.category2,
        this.category3,
        this.quantity,
        this.comments,
        this.images,
        this.audioFile,
        this.expenseStatus,
        this.quantityType});

  UtilizationData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    quantity = json['quantity'];
    comments = json['comments'];
    images = json['images'];
    audioFile = json['audio_file'];
    expenseStatus = json['ExpenseStatus'];
    quantityType = json['quantityType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['quantity'] = this.quantity;
    data['comments'] = this.comments;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['ExpenseStatus'] = this.expenseStatus;
    data['quantityType'] = this.quantityType;
    return data;
  }
}
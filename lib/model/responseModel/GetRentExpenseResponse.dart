class GetRentExpenseResponse {
  String? message;
  bool? error;
  List<GetRentData>? data;

  GetRentExpenseResponse({this.message, this.error, this.data});

  GetRentExpenseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetRentData>[];
      json['data'].forEach((v) {
        data!.add(new GetRentData.fromJson(v));
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

class GetRentData {
  String? id;
  String? category1;
  String? category2;
  String? category3;
  String? startingHr;
  String? endHr;
  String? startingKM;
  String? endKM;
  String? comment;
  String? durationType;
  String? duration;
  String? balanceAmount;
  String? vendorName;
  String? advance;
  String? rentType;
  String? totalCharges;
  String? expenseDate;
  String? expenseAmount;
  String? rate;
  String? images;
  String? audioFile;
  String? startingImage;
  String? endingImage;
  String? vendorAddress;
  String? others;
  String? expenseStatus;

  GetRentData(
      {this.id,
        this.category1,
        this.category2,
        this.category3,
        this.startingHr,
        this.endHr,
        this.startingKM,
        this.endKM,
        this.comment,
        this.durationType,
        this.duration,
        this.balanceAmount,
        this.vendorName,
        this.advance,
        this.rentType,
        this.totalCharges,
        this.expenseDate,
        this.expenseAmount,
        this.rate,
        this.images,
        this.audioFile,
        this.startingImage,
        this.endingImage,
        this.vendorAddress,
        this.others,
        this.expenseStatus});

  GetRentData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    startingHr = json['starting_hr'];
    endHr = json['end_hr'];
    startingKM = json['starting_KM'];
    endKM = json['end_KM'];
    comment = json['comment'];
    durationType = json['duration_type'];
    duration = json['duration'];
    balanceAmount = json['BalanceAmount'];
    vendorName = json['vendor_name'];
    advance = json['advance'];
    rentType = json['rent_type'];
    totalCharges = json['total_charges'];
    expenseDate = json['expenseDate'];
    expenseAmount = json['expense_amount'];
    rate = json['Rate'];
    images = json['images'];
    audioFile = json['audio_file'];
    startingImage = json['starting_image'];
    endingImage = json['ending_image'];
    vendorAddress = json['vendor_address'];
    others = json['others'];
    expenseStatus = json['ExpenseStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['starting_hr'] = this.startingHr;
    data['end_hr'] = this.endHr;
    data['starting_KM'] = this.startingKM;
    data['end_KM'] = this.endKM;
    data['comment'] = this.comment;
    data['duration_type'] = this.durationType;
    data['duration'] = this.duration;
    data['BalanceAmount'] = this.balanceAmount;
    data['vendor_name'] = this.vendorName;
    data['advance'] = this.advance;
    data['rent_type'] = this.rentType;
    data['total_charges'] = this.totalCharges;
    data['expenseDate'] = this.expenseDate;
    data['expense_amount'] = this.expenseAmount;
    data['Rate'] = this.rate;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['starting_image'] = this.startingImage;
    data['ending_image'] = this.endingImage;
    data['vendor_address'] = this.vendorAddress;
    data['others'] = this.others;
    data['ExpenseStatus'] = this.expenseStatus;
    return data;
  }
}
class TravelSummaryList {
  String? message;
  bool? error;
  List<TravelData>? data;

  TravelSummaryList({this.message, this.error, this.data});

  TravelSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <TravelData>[];
      json['data'].forEach((v) {
        data!.add(new TravelData.fromJson(v));
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

class TravelData {
  int? id;
  String? category1;
  String? category2;
  String? category3;
  String? fromDate;
  String? toDate;
  String? startingKM;
  String? endKM;
  String? tollCharges;
  String? amount;
  String? comments;
  String? ticketCharges;
  String? expenseDate;
  dynamic? expenseStatus;
  String? rentedOrOwned;
  int? perDuration;
  int? rate;
  int? balanceAmount;
  int? advance;
  String? registerationNumber;
  int? noOfTicket;
  String? perDurationType;
  String? vendorName;
  String? audioFile;
  String? driverTips;
  String? images;
  String? category4;
  String? category5;
  String? othersTravel;

  TravelData(
      {this.id,
        this.category1,
        this.category2,
        this.category3,
        this.fromDate,
        this.toDate,
        this.startingKM,
        this.endKM,
        this.tollCharges,
        this.amount,
        this.comments,
        this.ticketCharges,
        this.expenseDate,
        this.expenseStatus,
        this.rentedOrOwned,
        this.perDuration,
        this.rate,
        this.balanceAmount,
        this.advance,
        this.registerationNumber,
        this.noOfTicket,
        this.perDurationType,
        this.vendorName,
        this.audioFile,
        this.driverTips,
        this.images,
        this.category4,
        this.category5,
        this.othersTravel});

  TravelData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    startingKM = json['starting_KM'];
    endKM = json['end_KM'];
    tollCharges = json['toll_charges'];
    amount = json['amount'];
    comments = json['comments'];
    ticketCharges = json['ticket_charges'];
    expenseDate = json['expenseDate'];
    expenseStatus = json['ExpenseStatus'];
    rentedOrOwned = json['RentedOrOwned'];
    perDuration = json['PerDuration'];
    rate = json['Rate'];
    balanceAmount = json['BalanceAmount'];
    advance = json['Advance'];
    registerationNumber = json['RegisterationNumber'];
    noOfTicket = json['no_of_ticket'];
    perDurationType = json['PerDurationType'];
    vendorName = json['VendorName'];
    audioFile = json['audio_file'];
    driverTips = json['driver_tips'];
    images = json['images'];
    category4 = json['category4'];
    category5 = json['category5'];
    othersTravel = json['OthersTravel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['starting_KM'] = this.startingKM;
    data['end_KM'] = this.endKM;
    data['toll_charges'] = this.tollCharges;
    data['amount'] = this.amount;
    data['comments'] = this.comments;
    data['ticket_charges'] = this.ticketCharges;
    data['expenseDate'] = this.expenseDate;
    data['ExpenseStatus'] = this.expenseStatus;
    data['RentedOrOwned'] = this.rentedOrOwned;
    data['PerDuration'] = this.perDuration;
    data['Rate'] = this.rate;
    data['BalanceAmount'] = this.balanceAmount;
    data['Advance'] = this.advance;
    data['RegisterationNumber'] = this.registerationNumber;
    data['no_of_ticket'] = this.noOfTicket;
    data['PerDurationType'] = this.perDurationType;
    data['VendorName'] = this.vendorName;
    data['audio_file'] = this.audioFile;
    data['driver_tips'] = this.driverTips;
    data['images'] = this.images;
    data['category4'] = this.category4;
    data['category5'] = this.category5;
    data['OthersTravel'] = this.othersTravel;
    return data;
  }
}
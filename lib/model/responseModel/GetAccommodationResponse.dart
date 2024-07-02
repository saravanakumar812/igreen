class GetAccommodationResponse {
  String? message;
  bool? error;
  List<GetAccommodationData>? data;

  GetAccommodationResponse({this.message, this.error, this.data});

  GetAccommodationResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetAccommodationData>[];
      json['data'].forEach((v) {
        data!.add(new GetAccommodationData.fromJson(v));
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

class GetAccommodationData {
  String? id;
  String? category1;
  String? category2;
  String? address;
  String? advance;
  String? rentPerMonth;
  String? duration;
  String? balanceAmount;
  String? totalAmount;
  String? comments;
  String? checkIn;
  String? checkOut;
  String? expenseDate;
  String? ledgerName;
  String? contactNumber;
  String? numberOfRooms;
  String? roomNumber;
  String? extraChargesFor;
  String? extraCharges;
  String? perRate;
  String? images;
  String? audioFile;
  String? ownerDetails;
  String? panCard;
  String? maintanence;
  String? lumsumCharges;
  String? currentBillAmount;
  String? brokerageAmount;
  String? expenseStatus;
  String? billType;

  GetAccommodationData(
      {this.id,
        this.category1,
        this.category2,
        this.address,
        this.advance,
        this.rentPerMonth,
        this.duration,
        this.balanceAmount,
        this.totalAmount,
        this.comments,
        this.checkIn,
        this.checkOut,
        this.expenseDate,
        this.ledgerName,
        this.contactNumber,
        this.numberOfRooms,
        this.roomNumber,
        this.extraChargesFor,
        this.extraCharges,
        this.perRate,
        this.images,
        this.audioFile,
        this.ownerDetails,
        this.panCard,
        this.maintanence,
        this.lumsumCharges,
        this.currentBillAmount,
        this.brokerageAmount,
        this.expenseStatus,
        this.billType});

  GetAccommodationData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    category1 = json['category1'];
    category2 = json['category2'];
    address = json['address'];
    advance = json['advance'];
    rentPerMonth = json['rent_per_month'];
    duration = json['Duration'];
    balanceAmount = json['balanceAmount'];
    totalAmount = json['total_amount'];
    comments = json['comments'];
    checkIn = json['checkIn'];
    checkOut = json['checkOut'];
    expenseDate = json['expenseDate'];
    ledgerName = json['ledgerName'];
    contactNumber = json['contactNumber'];
    numberOfRooms = json['numberOfRooms'];
    roomNumber = json['roomNumber'];
    extraChargesFor = json['extraChargesFor'];
    extraCharges = json['extraCharges'];
    perRate = json['perRate'];
    images = json['images'];
    audioFile = json['audio_file'];
    ownerDetails = json['owner_details'];
    panCard = json['pan_card'];
    maintanence = json['maintanence'];
    lumsumCharges = json['lumsum_charges'];
    currentBillAmount = json['current_bill_amount'];
    brokerageAmount = json['brokerage_amount'];
    expenseStatus = json['ExpenseStatus'];
    billType = json['billType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['address'] = this.address;
    data['advance'] = this.advance;
    data['rent_per_month'] = this.rentPerMonth;
    data['Duration'] = this.duration;
    data['balanceAmount'] = this.balanceAmount;
    data['total_amount'] = this.totalAmount;
    data['comments'] = this.comments;
    data['checkIn'] = this.checkIn;
    data['checkOut'] = this.checkOut;
    data['expenseDate'] = this.expenseDate;
    data['ledgerName'] = this.ledgerName;
    data['contactNumber'] = this.contactNumber;
    data['numberOfRooms'] = this.numberOfRooms;
    data['roomNumber'] = this.roomNumber;
    data['extraChargesFor'] = this.extraChargesFor;
    data['extraCharges'] = this.extraCharges;
    data['perRate'] = this.perRate;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['owner_details'] = this.ownerDetails;
    data['pan_card'] = this.panCard;
    data['maintanence'] = this.maintanence;
    data['lumsum_charges'] = this.lumsumCharges;
    data['current_bill_amount'] = this.currentBillAmount;
    data['brokerage_amount'] = this.brokerageAmount;
    data['ExpenseStatus'] = this.expenseStatus;
    data['billType'] = this.billType;
    return data;
  }
}
class GetFuelExpenseResponse {
  String? message;
  bool? error;
  List<FuelExpenseData>? data;

  GetFuelExpenseResponse({this.message, this.error, this.data});

  GetFuelExpenseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <FuelExpenseData>[];
      json['data'].forEach((v) {
        data!.add(new FuelExpenseData.fromJson(v));
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

class FuelExpenseData {
  String? fuelExpenseId;
  String? employeeId;
  String? projectCode;
  String? category1;
  String? category2;
  String? category3;
  String? category4;
  String? category5;
  String? rentedOrOwned;
  String? vendorName;
  String? startingHr;
  String? endHr;
  String? startingImage;
  String? endingImage;
  String? quantity;
  String? amount;
  String? registerationNumber;
  String? vechicalDetails;
  String? startKM;
  String? endKM;
  String? comment;
  String? rate;
  String? lumsumCharges;
  String? otherMachineCategories;
  String? otherVehicleCategories;
  String? phase;
  String? otherPhase;
  String? images;
  String? audioFile;
  String? expenseAmount;
  String? expenseDate;
  String? expenseStatus;
  String? types;
  String? sgst;
  String? cgst;
  String? igst;
  String? createdAt;

  FuelExpenseData(
      {this.fuelExpenseId,
      this.employeeId,
      this.projectCode,
      this.category1,
      this.category2,
      this.category3,
      this.category4,
      this.category5,
      this.rentedOrOwned,
      this.vendorName,
      this.startingHr,
      this.endHr,
      this.startingImage,
      this.endingImage,
      this.quantity,
      this.amount,
      this.registerationNumber,
      this.vechicalDetails,
      this.startKM,
      this.endKM,
      this.comment,
      this.rate,
      this.lumsumCharges,
      this.otherMachineCategories,
      this.otherVehicleCategories,
      this.phase,
      this.otherPhase,
      this.images,
      this.audioFile,
      this.expenseAmount,
      this.expenseDate,
      this.expenseStatus,
      this.types,
      this.sgst,
      this.cgst,
      this.igst,
      this.createdAt});

  FuelExpenseData.fromJson(Map<String, dynamic> json) {
    fuelExpenseId = json['fuelExpenseId'];
    employeeId = json['EmployeeId'];
    projectCode = json['ProjectCode'];
    category1 = json['category1'];
    category2 = json['category2'];
    category3 = json['category3'];
    category4 = json['category4'];
    category5 = json['category5'];
    rentedOrOwned = json['rented_or_owned'];
    vendorName = json['vendorName'];
    startingHr = json['starting_hr'];
    endHr = json['end_hr'];
    startingImage = json['starting_image'];
    endingImage = json['ending_image'];
    quantity = json['Quantity'];
    amount = json['amount'];
    registerationNumber = json['registeration_number'];
    vechicalDetails = json['vechicalDetails'];
    startKM = json['start_KM'];
    endKM = json['end_KM'];
    comment = json['comment'];
    rate = json['rate'];
    lumsumCharges = json['lumsum_charges'];
    otherMachineCategories = json['other_machine_categories'];
    otherVehicleCategories = json['other_vehicle_categories'];
    phase = json['phase'];
    otherPhase = json['other_phase'];
    images = json['images'];
    audioFile = json['audio_file'];
    expenseAmount = json['expense_amount'];
    expenseDate = json['expenseDate'];
    expenseStatus = json['expense_status'];
    types = json['types'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    igst = json['igst'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fuelExpenseId'] = this.fuelExpenseId;
    data['EmployeeId'] = this.employeeId;
    data['ProjectCode'] = this.projectCode;
    data['category1'] = this.category1;
    data['category2'] = this.category2;
    data['category3'] = this.category3;
    data['category4'] = this.category4;
    data['category5'] = this.category5;
    data['rented_or_owned'] = this.rentedOrOwned;
    data['vendorName'] = this.vendorName;
    data['starting_hr'] = this.startingHr;
    data['end_hr'] = this.endHr;
    data['starting_image'] = this.startingImage;
    data['ending_image'] = this.endingImage;
    data['Quantity'] = this.quantity;
    data['amount'] = this.amount;
    data['registeration_number'] = this.registerationNumber;
    data['vechicalDetails'] = this.vechicalDetails;
    data['start_KM'] = this.startKM;
    data['end_KM'] = this.endKM;
    data['comment'] = this.comment;
    data['rate'] = this.rate;
    data['lumsum_charges'] = this.lumsumCharges;
    data['other_machine_categories'] = this.otherMachineCategories;
    data['other_vehicle_categories'] = this.otherVehicleCategories;
    data['phase'] = this.phase;
    data['other_phase'] = this.otherPhase;
    data['images'] = this.images;
    data['audio_file'] = this.audioFile;
    data['expense_amount'] = this.expenseAmount;
    data['expenseDate'] = this.expenseDate;
    data['expense_status'] = this.expenseStatus;
    data['types'] = this.types;
    data['sgst'] = this.sgst;
    data['cgst'] = this.cgst;
    data['igst'] = this.igst;
    data['created_at'] = this.createdAt;
    return data;
  }
}

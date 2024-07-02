class GraphResponseModel {
  String? message;
  bool? error;
  Data? data;

  GraphResponseModel({this.message, this.error, this.data});

  GraphResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? food;
  int? rental;
  int? travel;
  int? transport;
  int? accommodation;
  int? repairsAndMaintenance;
  int? general;
  int? wages;
  int? purchases;
  int? utilization;
  int? other;

  Data(
      {this.food,
        this.rental,
        this.travel,
        this.transport,
        this.accommodation,
        this.repairsAndMaintenance,
        this.general,
        this.wages,
        this.purchases,
        this.utilization,
        this.other});

  Data.fromJson(Map<String, dynamic> json) {
    food = json['Food'];
    rental = json['Rental'];
    travel = json['Travel'];
    transport = json['Transport'];
    accommodation = json['Accommodation'];
    repairsAndMaintenance = json['Repairs and Maintenance'];
    general = json['General'];
    wages = json['Wages'];
    purchases = json['Purchases'];
    utilization = json['Utilization'];
    other = json['Other'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Food'] = this.food;
    data['Rental'] = this.rental;
    data['Travel'] = this.travel;
    data['Transport'] = this.transport;
    data['Accommodation'] = this.accommodation;
    data['Repairs and Maintenance'] = this.repairsAndMaintenance;
    data['General'] = this.general;
    data['Wages'] = this.wages;
    data['Purchases'] = this.purchases;
    data['Utilization'] = this.utilization;
    data['Other'] = this.other;
    return data;
  }
}
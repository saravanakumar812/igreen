class GetGeneralCodeClientNameResponseModel {
  String? message;
  bool? error;
  List<GetGeneralCodeClientNameResponseModelData>? data;

  GetGeneralCodeClientNameResponseModel({this.message, this.error, this.data});

  GetGeneralCodeClientNameResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetGeneralCodeClientNameResponseModelData>[];
      json['data'].forEach((v) {
        data!.add(new GetGeneralCodeClientNameResponseModelData.fromJson(v));
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

class GetGeneralCodeClientNameResponseModelData {
  int? id;
  String? clientName;

  GetGeneralCodeClientNameResponseModelData({this.id, this.clientName});

  GetGeneralCodeClientNameResponseModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['client_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_name'] = this.clientName;
    return data;
  }
}



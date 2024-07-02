class DeductionDropDownResponseModel {
  String? message;
  bool? error;
  List<DeductionDropDownResponseModelData>? data;

  DeductionDropDownResponseModel({this.message, this.error, this.data});

  DeductionDropDownResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DeductionDropDownResponseModelData>[];
      json['data'].forEach((v) {
        data!.add(new DeductionDropDownResponseModelData.fromJson(v));
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

class DeductionDropDownResponseModelData {
  String? deductionName;

  DeductionDropDownResponseModelData({this.deductionName});

  DeductionDropDownResponseModelData.fromJson(Map<String, dynamic> json) {
    deductionName = json['deductionName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deductionName'] = this.deductionName;
    return data;
  }
}
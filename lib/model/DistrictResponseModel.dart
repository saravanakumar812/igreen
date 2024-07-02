class DistrictResponseModel {
  String? message;
  bool? error;
  List<DistrictDepartmentData>? data;

  DistrictResponseModel({this.message, this.error, this.data});

  DistrictResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <DistrictDepartmentData>[];
      json['data'].forEach((v) {
        data!.add(new DistrictDepartmentData.fromJson(v));
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

class DistrictDepartmentData {
  int? districtId;
  int? stateId;
  String? districtName;

  DistrictDepartmentData({this.districtId, this.stateId, this.districtName});

  DistrictDepartmentData.fromJson(Map<String, dynamic> json) {
    districtId = json['DistrictId'];
    stateId = json['StateId'];
    districtName = json['DistrictName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DistrictId'] = this.districtId;
    data['StateId'] = this.stateId;
    data['DistrictName'] = this.districtName;
    return data;
  }
}
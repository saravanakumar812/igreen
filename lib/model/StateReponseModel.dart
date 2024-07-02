class StateResponseModel {
  String? message;
  bool? error;
  List<StateDepartmentData>? data;

  StateResponseModel({this.message, this.error, this.data});

  StateResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <StateDepartmentData>[];
      json['data'].forEach((v) {
        data!.add(new StateDepartmentData.fromJson(v));
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

class StateDepartmentData {
  int? stateId;
  String? stateName;
  String? stateCode;

  StateDepartmentData({this.stateId, this.stateName, this.stateCode});

  StateDepartmentData.fromJson(Map<String, dynamic> json) {
    stateId = json['StateId'];
    stateName = json['StateName'];
    stateCode = json['StateCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StateId'] = this.stateId;
    data['StateName'] = this.stateName;
    data['StateCode'] = this.stateCode;
    return data;
  }
}
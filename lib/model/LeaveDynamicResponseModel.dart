class LeaveDynamic {
  String? message;
  bool? error;
  List<LeaveDynamicData>? data;

  LeaveDynamic({this.message, this.error, this.data});

  LeaveDynamic.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <LeaveDynamicData>[];
      json['data'].forEach((v) {
        data!.add(new LeaveDynamicData.fromJson(v));
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

class LeaveDynamicData {
  int? id;
  int? totalLeave;
  int? medicalLeave;
  int? casualLeave;
  int? sickLeave;
  int? privilegeLeave;
  int? otherLeave;
  String? createdAt;

  LeaveDynamicData(
      {this.id,
        this.totalLeave,
        this.medicalLeave,
        this.casualLeave,
        this.sickLeave,
        this.privilegeLeave,
        this.otherLeave,
        this.createdAt});

  LeaveDynamicData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalLeave = json['Total_leave'];
    medicalLeave = json['medical_leave'];
    casualLeave = json['casual_leave'];
    sickLeave = json['sick_leave'];
    privilegeLeave = json['privilege_leave'];
    otherLeave = json['other_leave'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Total_leave'] = this.totalLeave;
    data['medical_leave'] = this.medicalLeave;
    data['casual_leave'] = this.casualLeave;
    data['sick_leave'] = this.sickLeave;
    data['privilege_leave'] = this.privilegeLeave;
    data['other_leave'] = this.otherLeave;
    data['created_at'] = this.createdAt;
    return data;
  }
}
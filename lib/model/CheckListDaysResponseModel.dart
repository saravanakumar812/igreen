class CheckListDays {
  String? message;
  bool? error;
  List<CheckListData>? data;


  CheckListDays({this.message, this.error, this.data});

  CheckListDays.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CheckListData>[];
      json['data'].forEach((v) {
        data!.add(new CheckListData.fromJson(v));
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

class CheckListData {
  String? id;
  String? maintenanceCategory;
  String? names;
  String? days;
  String? createdAt;

  CheckListData(
      {this.id,
        this.maintenanceCategory,
        this.names,
        this.days,
        this.createdAt});

  CheckListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    maintenanceCategory = json['maintenance_category'];
    names = json['names'];
    days = json['days'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['maintenance_category'] = this.maintenanceCategory;
    data['names'] = this.names;
    data['days'] = this.days;
    data['created_at'] = this.createdAt;
    return data;
  }
}
class PurchaseMaterialNameList {
  String? message;
  bool? error;
  List<PurchaseMaterialNameData>? data;

  PurchaseMaterialNameList({this.message, this.error, this.data});

  PurchaseMaterialNameList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <PurchaseMaterialNameData>[];
      json['data'].forEach((v) {
        data!.add(new PurchaseMaterialNameData.fromJson(v));
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

class PurchaseMaterialNameData {
  int? id;
  String? materialName;
  String? createdAt;

  PurchaseMaterialNameData({this.id, this.materialName, this.createdAt});

  PurchaseMaterialNameData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    materialName = json['material_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['material_name'] = this.materialName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
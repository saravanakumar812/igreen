class  PurchaseUnitList{
  String? message;
  bool? error;
  List<PurchaseUnitData>? data;

  PurchaseUnitList({this.message, this.error, this.data});

  PurchaseUnitList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <PurchaseUnitData>[];
      json['data'].forEach((v) {
        data!.add(new PurchaseUnitData.fromJson(v));
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

class PurchaseUnitData {
  int? id;
  int? purchaseMaterialNameId;
  String? unit;
  String? createdAt;

  PurchaseUnitData({this.id, this.purchaseMaterialNameId, this.unit, this.createdAt});

  PurchaseUnitData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseMaterialNameId = json['purchase_material_name_id'];
    unit = json['unit'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purchase_material_name_id'] = this.purchaseMaterialNameId;
    data['unit'] = this.unit;
    data['created_at'] = this.createdAt;
    return data;
  }
}
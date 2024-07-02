class ItemSummaryList {
  String? message;
  bool? error;
  List<ItemData>? data;

  ItemSummaryList({this.message, this.error, this.data});

  ItemSummaryList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ItemData>[];
      json['data'].forEach((v) {
        data!.add(new ItemData.fromJson(v));
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

class ItemData {
  int? id;
  String? itemCode;
  String? itemDescription;
  String? itemName;

  ItemData({this.id, this.itemCode, this.itemDescription, this.itemName});

  ItemData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    itemCode = json['ItemCode'];
    itemDescription = json['ItemDescription'];
    itemName = json['ItemName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['ItemCode'] = this.itemCode;
    data['ItemDescription'] = this.itemDescription;
    data['ItemName'] = this.itemName;
    return data;
  }
}
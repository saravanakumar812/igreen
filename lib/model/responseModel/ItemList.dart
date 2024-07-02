class ItemList {
  String? itemCode;
  String? itemDescription;
  String? setQuantity;
  String? quantity;
  String? size;
  String? itemName;
  String? itemValue;
  String? rawMaterialGrade;

  ItemList(
      {this.itemCode,
        this.itemDescription,
        this.setQuantity,
        this.quantity,
        this.size,
        this.itemName,
        this.itemValue,
        this.rawMaterialGrade});

  ItemList.fromJson(Map<String, dynamic> json) {
    itemCode = json['ItemCode'];
    itemDescription = json['ItemDescription'];
    setQuantity = json['SetQuantity'];
    quantity = json['Quantity'];
    size = json['Size'];
    itemName = json['ItemName'];
    itemValue = json['ItemValue'];
    rawMaterialGrade = json['RawMaterialGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemCode'] = this.itemCode;
    data['ItemDescription'] = this.itemDescription;
    data['SetQuantity'] = this.setQuantity;
    data['Quantity'] = this.quantity;
    data['Size'] = this.size;
    data['ItemName'] = this.itemName;
    data['ItemValue'] = this.itemValue;
    data['RawMaterialGrade'] = this.rawMaterialGrade;
    return data;
  }
}
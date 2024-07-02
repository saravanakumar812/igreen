class SalesTeamList {
  String? message;
  bool? error;
  List<SalesTeamData>? salesData;

  SalesTeamList({this.message, this.error, this.salesData});

  SalesTeamList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      salesData = <SalesTeamData>[];
      json['data'].forEach((v) {
        salesData!.add(new SalesTeamData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.salesData != null) {
      data['data'] = this.salesData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesTeamData {
  int? projectId;
  String? customerName;
  String? mobileNum;
  String? email;
  String? companyName;
  String? companyAddress;
  String? gST;
  String? services;
  String? projectBudget;
  String? projectName;
  String? projectType;
  String? projectCode;
  String? projectDocuments;
  String? projectDescp;
  String? orderConfirmedDate;
  String? customerRequiredDate;
  String? dispatchCommittedDate;
  int? orderValue;
  String? shipmentAddress;
  String? transpotationScope;
  int? projectStatus;
  int? managerId;
  String? managerName;
  String? department;
  String? startDate;
  String? endDate;
  int? departmentId;
  String? remarks;
  String? customerLocation;
  String? websiteDetails;
  String? deliveryAddress;
  int? secondaryContact;
  String? materialFromClient;
  String? pickupAddress;
  int? factoryStatus;
  String? commercialUpload;
  String? technicalUpload;
  String? process;
  List<FactoryProjectsItems>? factoryProjectsItems;

  SalesTeamData(
      {this.projectId,
        this.customerName,
        this.mobileNum,
        this.email,
        this.companyName,
        this.companyAddress,
        this.gST,
        this.services,
        this.projectBudget,
        this.projectName,
        this.projectType,
        this.projectCode,
        this.projectDocuments,
        this.projectDescp,
        this.orderConfirmedDate,
        this.customerRequiredDate,
        this.dispatchCommittedDate,
        this.orderValue,
        this.shipmentAddress,
        this.transpotationScope,
        this.projectStatus,
        this.managerId,
        this.managerName,
        this.department,
        this.startDate,
        this.endDate,
        this.departmentId,
        this.remarks,
        this.customerLocation,
        this.websiteDetails,
        this.deliveryAddress,
        this.secondaryContact,
        this.materialFromClient,
        this.pickupAddress,
        this.factoryStatus,
        this.commercialUpload,
        this.technicalUpload,
        this.process,
        this.factoryProjectsItems});

  SalesTeamData.fromJson(Map<String, dynamic> json) {
    projectId = json['ProjectId'];
    customerName = json['CustomerName'];
    mobileNum = json['MobileNum'];
    email = json['Email'];
    companyName = json['CompanyName'];
    companyAddress = json['CompanyAddress'];
    gST = json['GST'];
    services = json['Services'];
    projectBudget = json['ProjectBudget'];
    projectName = json['ProjectName'];
    projectType = json['ProjectType'];
    projectCode = json['ProjectCode'];
    projectDocuments = json['ProjectDocuments'];
    projectDescp = json['ProjectDescp'];
    orderConfirmedDate = json['OrderConfirmedDate'];
    customerRequiredDate = json['CustomerRequiredDate'];
    dispatchCommittedDate = json['DispatchCommittedDate'];
    orderValue = json['OrderValue'];
    shipmentAddress = json['ShipmentAddress'];
    transpotationScope = json['TranspotationScope'];
    projectStatus = json['ProjectStatus'];
    managerId = json['ManagerId'];
    managerName = json['ManagerName'];
    department = json['Department'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    departmentId = json['DepartmentId'];
    remarks = json['Remarks'];
    customerLocation = json['CustomerLocation'];
    websiteDetails = json['WebsiteDetails'];
    deliveryAddress = json['DeliveryAddress'];
    secondaryContact = json['SecondaryContact'];
    materialFromClient = json['MaterialFromClient'];
    pickupAddress = json['PickupAddress'];
    factoryStatus = json['FactoryStatus'];
    commercialUpload = json['CommercialUpload'];
    technicalUpload = json['TechnicalUpload'];
    process = json['Process'];
    if (json['FactoryProjectsItems'] != null) {
      factoryProjectsItems = <FactoryProjectsItems>[];
      json['FactoryProjectsItems'].forEach((v) {
        factoryProjectsItems!.add(new FactoryProjectsItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ProjectId'] = this.projectId;
    data['CustomerName'] = this.customerName;
    data['MobileNum'] = this.mobileNum;
    data['Email'] = this.email;
    data['CompanyName'] = this.companyName;
    data['CompanyAddress'] = this.companyAddress;
    data['GST'] = this.gST;
    data['Services'] = this.services;
    data['ProjectBudget'] = this.projectBudget;
    data['ProjectName'] = this.projectName;
    data['ProjectType'] = this.projectType;
    data['ProjectCode'] = this.projectCode;
    data['ProjectDocuments'] = this.projectDocuments;
    data['ProjectDescp'] = this.projectDescp;
    data['OrderConfirmedDate'] = this.orderConfirmedDate;
    data['CustomerRequiredDate'] = this.customerRequiredDate;
    data['DispatchCommittedDate'] = this.dispatchCommittedDate;
    data['OrderValue'] = this.orderValue;
    data['ShipmentAddress'] = this.shipmentAddress;
    data['TranspotationScope'] = this.transpotationScope;
    data['ProjectStatus'] = this.projectStatus;
    data['ManagerId'] = this.managerId;
    data['ManagerName'] = this.managerName;
    data['Department'] = this.department;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['DepartmentId'] = this.departmentId;
    data['Remarks'] = this.remarks;
    data['CustomerLocation'] = this.customerLocation;
    data['WebsiteDetails'] = this.websiteDetails;
    data['DeliveryAddress'] = this.deliveryAddress;
    data['SecondaryContact'] = this.secondaryContact;
    data['MaterialFromClient'] = this.materialFromClient;
    data['PickupAddress'] = this.pickupAddress;
    data['FactoryStatus'] = this.factoryStatus;
    data['CommercialUpload'] = this.commercialUpload;
    data['TechnicalUpload'] = this.technicalUpload;
    data['Process'] = this.process;
    if (this.factoryProjectsItems != null) {
      data['FactoryProjectsItems'] =
          this.factoryProjectsItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FactoryProjectsItems {
  int? itemId;
  int? factoryProjectId;
  String? itemCode;
  String? itemDescription;
  String? quantity;
  String? size;
  String? itemName;
  String? itemValue;
  String? rawMaterialGrade;

  FactoryProjectsItems(
      {this.itemId,
        this.factoryProjectId,
        this.itemCode,
        this.itemDescription,
        this.quantity,
        this.size,
        this.itemName,
        this.itemValue,
        this.rawMaterialGrade});

  FactoryProjectsItems.fromJson(Map<String, dynamic> json) {
    itemId = json['ItemId'];
    factoryProjectId = json['factoryProjectId'];
    itemCode = json['ItemCode'];
    itemDescription = json['ItemDescription'];
    quantity = json['Quantity'];
    size = json['Size'];
    itemName = json['ItemName'];
    itemValue = json['ItemValue'];
    rawMaterialGrade = json['RawMaterialGrade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ItemId'] = this.itemId;
    data['factoryProjectId'] = this.factoryProjectId;
    data['ItemCode'] = this.itemCode;
    data['ItemDescription'] = this.itemDescription;
    data['Quantity'] = this.quantity;
    data['Size'] = this.size;
    data['ItemName'] = this.itemName;
    data['ItemValue'] = this.itemValue;
    data['RawMaterialGrade'] = this.rawMaterialGrade;
    return data;
  }
}
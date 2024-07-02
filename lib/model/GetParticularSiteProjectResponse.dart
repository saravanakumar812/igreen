class GetParticularSiteProjectResponse {
  String? message;
  bool? error;
  List<GetParticularSiteProjectResponseData>? data;

  GetParticularSiteProjectResponse({this.message, this.error, this.data});

  GetParticularSiteProjectResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <GetParticularSiteProjectResponseData>[];
      json['data'].forEach((v) {
        data!.add(new GetParticularSiteProjectResponseData.fromJson(v));
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

class GetParticularSiteProjectResponseData {
  int? siteProjectId;
  int? lastUpdatedEmployeeID;
  String? lastUpdatedEmployeeName;
  String? clientName;
  String? projectType;
  String? monthYear;
  int? serialNum;
  String? projectState;
  String? projectDistrict;
  String? projectArea;
  String? projectCode;
  String? tenderType;
  String? tenderSpecRemarks;
  String? tenderSpecFile;
  String? openingDate;
  String? openingDateRemarks;
  String? closingDate;
  String? closingDateRemarks;
  String? emdExemptionFile;
  String? emdExemptionRemarks;
  String? tenderLost;
  String? tenderLostRemarks;
  int? amount;
  String? opponentCompany;
  String? billDeductionFile;
  String? billDeductionRemarks;
  String? boqFile;
  String? boqRemarks;
  String? projectDetailsFile;
  String? projectDetailsRemarks;
  String? workOrderFile;
  String? workOrderRemarks;
  String? profileDrawing;
  String? profileDrawingRemarks;
  String? agreementFile;
  String? agreementRemarks;
  String? budgetFile;
  String? budgetRemarks;
  String? subcontract;
  String? subcontractName;
  String? subcontractNameRemarks;
  String? subcontractOrder;
  String? subcontractOrderRemarks;
  String? subcontractScopeWork;
  String? subcontractScopeWorkRemarks;
  String? ourScopeOfWork;
  String? ourScopeOfWorkRemarks;
  String? machineOrSubcontract;
  String? machineOrSubcontractRemark;
  String? billingFile;
  String? billingRemarks;
  String? flowBills;
  String? flowBillsRemarks;
  String? paymentReceived;
  String? paymentReceivedRemarks;
  String? emdRetentionDate;
  String? emdRetentionRemarks;
  String? emdAmount;
  String? sdRetentionDate;
  String? sdRetentionRemarks;
  String? sdAmount;
  String? otherRetentionDate;
  String? otherRetentionRemarks;
  String? otherAmount;
  String? bqrFile;
  String? bqrRemarks;
  String? hdd;
  String? escavatorsSmall;
  String? hydraSmall;
  String? hydraBig;
  String? generator;
  String? weldingMachine;
  String? grindingMachine;
  String? clamp;
  String? rollersSmall;
  String? rollersBig;
  String? cradels;
  String? drumStands;
  String? winchMachine;
  String? manPower;
  String? manualOurScopeEntries;
  String? lastUpdatedDate;
  String? subHDD;
  String? subEscavatorsSmall;
  String? subHydraSmall;
  String? subHydraBig;
  String? subGenerator;
  String? subWeldingMachine;
  String? subClamp;
  String? subRollersSmall;
  String? subRollersBig;
  String? subCradels;
  String? subDrumStands;
  String? subWinchMachine;
  String? subGrindingMachine;
  String? submanPower;
  String? subImage;
  String? qualified;
  String? emdFile;
  String? sdFile;
  String? otherFile;
  int? tenderAmount;
  List<SiteProjectTendersData>? siteProjectTenders;

  GetParticularSiteProjectResponseData(
      {this.siteProjectId,
        this.lastUpdatedEmployeeID,
        this.lastUpdatedEmployeeName,
        this.clientName,
        this.projectType,
        this.monthYear,
        this.serialNum,
        this.projectState,
        this.projectDistrict,
        this.projectArea,
        this.projectCode,
        this.tenderType,
        this.tenderSpecRemarks,
        this.tenderSpecFile,
        this.openingDate,
        this.openingDateRemarks,
        this.closingDate,
        this.closingDateRemarks,
        this.emdExemptionFile,
        this.emdExemptionRemarks,
        this.tenderLost,
        this.tenderLostRemarks,
        this.amount,
        this.opponentCompany,
        this.billDeductionFile,
        this.billDeductionRemarks,
        this.boqFile,
        this.boqRemarks,
        this.projectDetailsFile,
        this.projectDetailsRemarks,
        this.workOrderFile,
        this.workOrderRemarks,
        this.profileDrawing,
        this.profileDrawingRemarks,
        this.agreementFile,
        this.agreementRemarks,
        this.budgetFile,
        this.budgetRemarks,
        this.subcontract,
        this.subcontractName,
        this.subcontractNameRemarks,
        this.subcontractOrder,
        this.subcontractOrderRemarks,
        this.subcontractScopeWork,
        this.subcontractScopeWorkRemarks,
        this.ourScopeOfWork,
        this.ourScopeOfWorkRemarks,
        this.machineOrSubcontract,
        this.machineOrSubcontractRemark,
        this.billingFile,
        this.billingRemarks,
        this.flowBills,
        this.flowBillsRemarks,
        this.paymentReceived,
        this.paymentReceivedRemarks,
        this.emdRetentionDate,
        this.emdRetentionRemarks,
        this.emdAmount,
        this.sdRetentionDate,
        this.sdRetentionRemarks,
        this.sdAmount,
        this.otherRetentionDate,
        this.otherRetentionRemarks,
        this.otherAmount,
        this.bqrFile,
        this.bqrRemarks,
        this.hdd,
        this.escavatorsSmall,
        this.hydraSmall,
        this.hydraBig,
        this.generator,
        this.weldingMachine,
        this.grindingMachine,
        this.clamp,
        this.rollersSmall,
        this.rollersBig,
        this.cradels,
        this.drumStands,
        this.winchMachine,
        this.manPower,
        this.manualOurScopeEntries,
        this.lastUpdatedDate,
        this.subHDD,
        this.subEscavatorsSmall,
        this.subHydraSmall,
        this.subHydraBig,
        this.subGenerator,
        this.subWeldingMachine,
        this.subClamp,
        this.subRollersSmall,
        this.subRollersBig,
        this.subCradels,
        this.subDrumStands,
        this.subWinchMachine,
        this.subGrindingMachine,
        this.submanPower,
        this.subImage,
        this.qualified,
        this.emdFile,
        this.sdFile,
        this.otherFile,
        this.tenderAmount,
        this.siteProjectTenders});

  GetParticularSiteProjectResponseData.fromJson(Map<String, dynamic> json) {
    siteProjectId = json['SiteProjectId'];
    lastUpdatedEmployeeID = json['lastUpdatedEmployeeID'];
    lastUpdatedEmployeeName = json['lastUpdatedEmployeeName'];
    clientName = json['clientName'];
    projectType = json['projectType'];
    monthYear = json['monthYear'];
    serialNum = json['serialNum'];
    projectState = json['projectState'];
    projectDistrict = json['projectDistrict'];
    projectArea = json['projectArea'];
    projectCode = json['projectCode'];
    tenderType = json['TenderType'];
    tenderSpecRemarks = json['TenderSpecRemarks'];
    tenderSpecFile = json['TenderSpecFile'];
    openingDate = json['OpeningDate'];
    openingDateRemarks = json['OpeningDateRemarks'];
    closingDate = json['closingDate'];
    closingDateRemarks = json['ClosingDateRemarks'];
    emdExemptionFile = json['emdExemptionFile'];
    emdExemptionRemarks = json['emdExemptionRemarks'];
    tenderLost = json['tenderLost'];
    tenderLostRemarks = json['tenderLostRemarks'];
    amount = json['amount'];
    opponentCompany = json['opponentCompany'];
    billDeductionFile = json['billDeductionFile'];
    billDeductionRemarks = json['billDeductionRemarks'];
    boqFile = json['boqFile'];
    boqRemarks = json['boqRemarks'];
    projectDetailsFile = json['projectDetailsFile'];
    projectDetailsRemarks = json['projectDetailsRemarks'];
    workOrderFile = json['workOrderFile'];
    workOrderRemarks = json['workOrderRemarks'];
    profileDrawing = json['profileDrawing'];
    profileDrawingRemarks = json['profileDrawingRemarks'];
    agreementFile = json['agreementFile'];
    agreementRemarks = json['agreementRemarks'];
    budgetFile = json['budgetFile'];
    budgetRemarks = json['budgetRemarks'];
    subcontract = json['subcontract'];
    subcontractName = json['subcontractName'];
    subcontractNameRemarks = json['subcontractNameRemarks'];
    subcontractOrder = json['subcontractOrder'];
    subcontractOrderRemarks = json['subcontractOrderRemarks'];
    subcontractScopeWork = json['subcontractScopeWork'];
    subcontractScopeWorkRemarks = json['subcontractScopeWorkRemarks'];
    ourScopeOfWork = json['ourScopeOfWork'];
    ourScopeOfWorkRemarks = json['ourScopeOfWorkRemarks'];
    machineOrSubcontract = json['machineOrSubcontract'];
    machineOrSubcontractRemark = json['machineOrSubcontractRemark'];
    billingFile = json['billingFile'];
    billingRemarks = json['billingRemarks'];
    flowBills = json['flowBills'];
    flowBillsRemarks = json['flowBillsRemarks'];
    paymentReceived = json['paymentReceived'];
    paymentReceivedRemarks = json['paymentReceivedRemarks'];
    emdRetentionDate = json['emdRetentionDate'];
    emdRetentionRemarks = json['emdRetentionRemarks'];
    emdAmount = json['emdAmount'];
    sdRetentionDate = json['sdRetentionDate'];
    sdRetentionRemarks = json['sdRetentionRemarks'];
    sdAmount = json['sdAmount'];
    otherRetentionDate = json['otherRetentionDate'];
    otherRetentionRemarks = json['otherRetentionRemarks'];
    otherAmount = json['otherAmount'];
    bqrFile = json['bqrFile'];
    bqrRemarks = json['bqrRemarks'];
    hdd = json['hdd'];
    escavatorsSmall = json['escavatorsSmall'];
    hydraSmall = json['hydraSmall'];
    hydraBig = json['hydraBig'];
    generator = json['generator'];
    weldingMachine = json['weldingMachine'];
    grindingMachine = json['grindingMachine'];
    clamp = json['clamp'];
    rollersSmall = json['rollersSmall'];
    rollersBig = json['rollersBig'];
    cradels = json['cradels'];
    drumStands = json['drumStands'];
    winchMachine = json['winchMachine'];
    manPower = json['manPower'];
    manualOurScopeEntries = json['ManualOurScopeEntries'];
    lastUpdatedDate = json['lastUpdatedDate'];
    subHDD = json['subHDD'];
    subEscavatorsSmall = json['subEscavatorsSmall'];
    subHydraSmall = json['subHydraSmall'];
    subHydraBig = json['subHydraBig'];
    subGenerator = json['subGenerator'];
    subWeldingMachine = json['subWeldingMachine'];
    subClamp = json['subClamp'];
    subRollersSmall = json['subRollersSmall'];
    subRollersBig = json['subRollersBig'];
    subCradels = json['subCradels'];
    subDrumStands = json['subDrumStands'];
    subWinchMachine = json['subWinchMachine'];
    subGrindingMachine = json['subGrindingMachine'];
    submanPower = json['submanPower'];
    subImage = json['subImage'];
    qualified = json['Qualified'];
    emdFile = json['emdFile'];
    sdFile = json['sdFile'];
    otherFile = json['otherFile'];
    tenderAmount = json['tenderAmount'];
    if (json['siteProjectTenders'] != null) {
      siteProjectTenders = <SiteProjectTendersData>[];
      json['siteProjectTenders'].forEach((v) {
        siteProjectTenders!.add(new SiteProjectTendersData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SiteProjectId'] = this.siteProjectId;
    data['lastUpdatedEmployeeID'] = this.lastUpdatedEmployeeID;
    data['lastUpdatedEmployeeName'] = this.lastUpdatedEmployeeName;
    data['clientName'] = this.clientName;
    data['projectType'] = this.projectType;
    data['monthYear'] = this.monthYear;
    data['serialNum'] = this.serialNum;
    data['projectState'] = this.projectState;
    data['projectDistrict'] = this.projectDistrict;
    data['projectArea'] = this.projectArea;
    data['projectCode'] = this.projectCode;
    data['TenderType'] = this.tenderType;
    data['TenderSpecRemarks'] = this.tenderSpecRemarks;
    data['TenderSpecFile'] = this.tenderSpecFile;
    data['OpeningDate'] = this.openingDate;
    data['OpeningDateRemarks'] = this.openingDateRemarks;
    data['closingDate'] = this.closingDate;
    data['ClosingDateRemarks'] = this.closingDateRemarks;
    data['emdExemptionFile'] = this.emdExemptionFile;
    data['emdExemptionRemarks'] = this.emdExemptionRemarks;
    data['tenderLost'] = this.tenderLost;
    data['tenderLostRemarks'] = this.tenderLostRemarks;
    data['amount'] = this.amount;
    data['opponentCompany'] = this.opponentCompany;
    data['billDeductionFile'] = this.billDeductionFile;
    data['billDeductionRemarks'] = this.billDeductionRemarks;
    data['boqFile'] = this.boqFile;
    data['boqRemarks'] = this.boqRemarks;
    data['projectDetailsFile'] = this.projectDetailsFile;
    data['projectDetailsRemarks'] = this.projectDetailsRemarks;
    data['workOrderFile'] = this.workOrderFile;
    data['workOrderRemarks'] = this.workOrderRemarks;
    data['profileDrawing'] = this.profileDrawing;
    data['profileDrawingRemarks'] = this.profileDrawingRemarks;
    data['agreementFile'] = this.agreementFile;
    data['agreementRemarks'] = this.agreementRemarks;
    data['budgetFile'] = this.budgetFile;
    data['budgetRemarks'] = this.budgetRemarks;
    data['subcontract'] = this.subcontract;
    data['subcontractName'] = this.subcontractName;
    data['subcontractNameRemarks'] = this.subcontractNameRemarks;
    data['subcontractOrder'] = this.subcontractOrder;
    data['subcontractOrderRemarks'] = this.subcontractOrderRemarks;
    data['subcontractScopeWork'] = this.subcontractScopeWork;
    data['subcontractScopeWorkRemarks'] = this.subcontractScopeWorkRemarks;
    data['ourScopeOfWork'] = this.ourScopeOfWork;
    data['ourScopeOfWorkRemarks'] = this.ourScopeOfWorkRemarks;
    data['machineOrSubcontract'] = this.machineOrSubcontract;
    data['machineOrSubcontractRemark'] = this.machineOrSubcontractRemark;
    data['billingFile'] = this.billingFile;
    data['billingRemarks'] = this.billingRemarks;
    data['flowBills'] = this.flowBills;
    data['flowBillsRemarks'] = this.flowBillsRemarks;
    data['paymentReceived'] = this.paymentReceived;
    data['paymentReceivedRemarks'] = this.paymentReceivedRemarks;
    data['emdRetentionDate'] = this.emdRetentionDate;
    data['emdRetentionRemarks'] = this.emdRetentionRemarks;
    data['emdAmount'] = this.emdAmount;
    data['sdRetentionDate'] = this.sdRetentionDate;
    data['sdRetentionRemarks'] = this.sdRetentionRemarks;
    data['sdAmount'] = this.sdAmount;
    data['otherRetentionDate'] = this.otherRetentionDate;
    data['otherRetentionRemarks'] = this.otherRetentionRemarks;
    data['otherAmount'] = this.otherAmount;
    data['bqrFile'] = this.bqrFile;
    data['bqrRemarks'] = this.bqrRemarks;
    data['hdd'] = this.hdd;
    data['escavatorsSmall'] = this.escavatorsSmall;
    data['hydraSmall'] = this.hydraSmall;
    data['hydraBig'] = this.hydraBig;
    data['generator'] = this.generator;
    data['weldingMachine'] = this.weldingMachine;
    data['grindingMachine'] = this.grindingMachine;
    data['clamp'] = this.clamp;
    data['rollersSmall'] = this.rollersSmall;
    data['rollersBig'] = this.rollersBig;
    data['cradels'] = this.cradels;
    data['drumStands'] = this.drumStands;
    data['winchMachine'] = this.winchMachine;
    data['manPower'] = this.manPower;
    data['ManualOurScopeEntries'] = this.manualOurScopeEntries;
    data['lastUpdatedDate'] = this.lastUpdatedDate;
    data['subHDD'] = this.subHDD;
    data['subEscavatorsSmall'] = this.subEscavatorsSmall;
    data['subHydraSmall'] = this.subHydraSmall;
    data['subHydraBig'] = this.subHydraBig;
    data['subGenerator'] = this.subGenerator;
    data['subWeldingMachine'] = this.subWeldingMachine;
    data['subClamp'] = this.subClamp;
    data['subRollersSmall'] = this.subRollersSmall;
    data['subRollersBig'] = this.subRollersBig;
    data['subCradels'] = this.subCradels;
    data['subDrumStands'] = this.subDrumStands;
    data['subWinchMachine'] = this.subWinchMachine;
    data['subGrindingMachine'] = this.subGrindingMachine;
    data['submanPower'] = this.submanPower;
    data['subImage'] = this.subImage;
    data['Qualified'] = this.qualified;
    data['emdFile'] = this.emdFile;
    data['sdFile'] = this.sdFile;
    data['otherFile'] = this.otherFile;
    data['tenderAmount'] = this.tenderAmount;
    if (this.siteProjectTenders != null) {
      data['siteProjectTenders'] =
          this.siteProjectTenders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class SiteProjectTendersData {
  int? itemId;
  int? factoryProjectId;
  String? itemCode;
  String? itemDescription;
  String? quantity;
  String? size;
  String? itemName;
  String? itemValue;
  String? rawMaterialGrade;

  SiteProjectTendersData(
      {this.itemId,
        this.factoryProjectId,
        this.itemCode,
        this.itemDescription,
        this.quantity,
        this.size,
        this.itemName,
        this.itemValue,
        this.rawMaterialGrade});

  SiteProjectTendersData.fromJson(Map<String, dynamic> json) {
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
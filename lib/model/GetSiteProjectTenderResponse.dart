class SiteProjectTenderResponse {
  String? message;
  bool? error;
  List<SiteProjectTenderResponseData>? data;

  SiteProjectTenderResponse({this.message, this.error, this.data});

  SiteProjectTenderResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SiteProjectTenderResponseData>[];
      json['data'].forEach((v) {
        data!.add(new SiteProjectTenderResponseData.fromJson(v));
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

class SiteProjectTenderResponseData {
  String? siteProjectId;
  int? siteTenderId;
  String? descriptions;
  String? unit;
  int? amount;
  List<SiteProjectTenders>? siteProjectTenders;

  SiteProjectTenderResponseData(
      {this.siteProjectId,
        this.siteTenderId,
        this.descriptions,
        this.unit,
        this.amount,
        this.siteProjectTenders});

  SiteProjectTenderResponseData.fromJson(Map<String, dynamic> json) {
    siteProjectId = json['SiteProjectId'];
    siteTenderId = json['siteTenderId'];
    descriptions = json['descriptions'];
    unit = json['unit'];
    amount = json['amount'];
    if (json['siteProjectTenders'] != null) {
      siteProjectTenders = <SiteProjectTenders>[];
      json['siteProjectTenders'].forEach((v) {
        siteProjectTenders!.add(new SiteProjectTenders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SiteProjectId'] = this.siteProjectId;
    data['siteTenderId'] = this.siteTenderId;
    data['descriptions'] = this.descriptions;
    data['unit'] = this.unit;
    data['amount'] = this.amount;
    if (this.siteProjectTenders != null) {
      data['siteProjectTenders'] =
          this.siteProjectTenders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SiteProjectTenders {
  int? siteTenderQtyId;
  String? qty;

  SiteProjectTenders({this.siteTenderQtyId, this.qty});

  SiteProjectTenders.fromJson(Map<String, dynamic> json) {
    siteTenderQtyId = json['siteTenderQtyId'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteTenderQtyId'] = this.siteTenderQtyId;
    data['qty'] = this.qty;
    return data;
  }
}
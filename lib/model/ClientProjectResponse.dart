class ClientProjectResponse {
  String? message;
  bool? error;
  List<ClientDepartmentData>? data;

  ClientProjectResponse({this.message, this.error, this.data});

  ClientProjectResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ClientDepartmentData>[];
      json['data'].forEach((v) {
        data!.add(new ClientDepartmentData.fromJson(v));
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

class ClientDepartmentData {
  int? clientId;
  String? clientName;

  ClientDepartmentData({this.clientId, this.clientName});

  ClientDepartmentData.fromJson(Map<String, dynamic> json) {
    clientId = json['ClientId'];
    clientName = json['ClientName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientId'] = this.clientId;
    data['ClientName'] = this.clientName;
    return data;
  }
}
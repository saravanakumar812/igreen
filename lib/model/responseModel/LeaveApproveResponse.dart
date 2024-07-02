class LeaveApproveResponse {
  String? message;
  bool? error;

  LeaveApproveResponse({this.message, this.error});

  LeaveApproveResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    return data;
  }
}

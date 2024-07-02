class CalenderLeaveList {
  String? message;
  bool? error;
  List<CalenderLeaveListData>? data;

  CalenderLeaveList({this.message, this.error, this.data});

  CalenderLeaveList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CalenderLeaveListData>[];
      json['data'].forEach((v) {
        data!.add(new CalenderLeaveListData.fromJson(v));
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

class CalenderLeaveListData {
  String? leaveDate;

  CalenderLeaveListData({this.leaveDate});

  CalenderLeaveListData.fromJson(Map<String, dynamic> json) {
    leaveDate = json['LeaveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveDate'] = this.leaveDate;
    return data;
  }
}
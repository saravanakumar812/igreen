class ReminderList {
  String? message;
  bool? error;
  List<ReminderData>? data;

  ReminderList({this.message, this.error, this.data});

  ReminderList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ReminderData>[];
      json['data'].forEach((v) {
        data!.add(new ReminderData.fromJson(v));
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

class ReminderData {
  String? remainderId;
  String? reminderTypeId;
  String? department;
  String? employeeId;
  String? projectCode;
  String? reminderType;
  String? reminderDate;
  String? comments;
  String? emiAmount;

  ReminderData(
      {this.remainderId,
        this.reminderTypeId,
        this.department,
        this.employeeId,
        this.projectCode,
        this.reminderType,
        this.reminderDate,
        this.comments,
        this.emiAmount});

  ReminderData.fromJson(Map<String, dynamic> json) {
    remainderId = json['RemainderId'];
    reminderTypeId = json['reminder_type_id'];
    department = json['department'];
    employeeId = json['employee_id'];
    projectCode = json['project_code'];
    reminderType = json['reminder_type'];
    reminderDate = json['reminder_date'] ?? "";
    comments = json['comments'];
    emiAmount = json['emi_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RemainderId'] = this.remainderId;
    data['reminder_type_id'] = this.reminderTypeId;
    data['department'] = this.department;
    data['employee_id'] = this.employeeId;
    data['project_code'] = this.projectCode;
    data['reminder_type'] = this.reminderType;
    data['reminder_date'] = this.reminderDate;
    data['comments'] = this.comments;
    data['emi_amount'] = this.emiAmount;
    return data;
  }
}

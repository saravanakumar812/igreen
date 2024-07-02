class EventList {
  String? message;
  bool? error;
  List<EventData>? eventsData;

  EventList({this.message, this.error, this.eventsData});

  EventList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      eventsData = <EventData>[];
      json['data'].forEach((v) {
        eventsData!.add(new EventData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.eventsData != null) {
      data['data'] = this.eventsData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventData {
  int? announcementId;
  String? title;
  int? departmentId;
  String? descriptions;
  String? startdate;
  String? enddate;
  String? startTime;
  String? endTime;
  int? employeeId;
  String? employeeName;

  EventData(
      {this.announcementId,
        this.title,
        this.departmentId,
        this.descriptions,
        this.startdate,
        this.enddate,
        this.startTime,
        this.endTime,
        this.employeeId,
        this.employeeName});

  EventData.fromJson(Map<String, dynamic> json) {
    announcementId = json['announcementId'];
    title = json['title'];
    departmentId = json['department_id'];
    descriptions = json['descriptions'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    employeeId = json['employee_id'];
    employeeName = json['employee_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['announcementId'] = this.announcementId;
    data['title'] = this.title;
    data['department_id'] = this.departmentId;
    data['descriptions'] = this.descriptions;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['employee_id'] = this.employeeId;
    data['employee_name'] = this.employeeName;
    return data;
  }
}
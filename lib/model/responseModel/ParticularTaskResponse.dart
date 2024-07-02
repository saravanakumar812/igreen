class ParticularTaskResponse {
  String? message;
  bool? error;
  List<ParticularData>? data;

  ParticularTaskResponse({this.message, this.error, this.data});

  ParticularTaskResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ParticularData>[];
      json['data'].forEach((v) {
        data!.add(new ParticularData.fromJson(v));
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

class ParticularData {
  int? taskId;
  String? names;
  String? types;
  String? code;
  String? department;
  String? resources;
  String? startdate;
  String? enddate;
  String? expectedCompletionDate;
  String? descriptions;
  String? taskStatus;
  String? priority;

  ParticularData(
      {this.taskId,
      this.names,
      this.types,
      this.code,
      this.department,
      this.resources,
      this.startdate,
      this.enddate,
      this.expectedCompletionDate,
      this.descriptions,
      this.taskStatus,
      this.priority});

  ParticularData.fromJson(Map<String, dynamic> json) {
    taskId = json['TaskId'];
    names = json['names'];
    types = json['types'];
    code = json['code'];
    department = json['department'];
    resources = json['resources'];
    startdate = json['startdate'];
    enddate = json['enddate'];
    expectedCompletionDate = json['expected_completion_date'];
    descriptions = json['descriptions'];
    taskStatus = json['TaskStatus'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TaskId'] = this.taskId;
    data['names'] = this.names;
    data['types'] = this.types;
    data['code'] = this.code;
    data['department'] = this.department;
    data['resources'] = this.resources;
    data['startdate'] = this.startdate;
    data['enddate'] = this.enddate;
    data['expected_completion_date'] = this.expectedCompletionDate;
    data['descriptions'] = this.descriptions;
    data['TaskStatus'] = this.taskStatus;
    data['priority'] = this.priority;
    return data;
  }
}

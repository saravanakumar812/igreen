class CompletedProjectResponse {
  String? message;
  bool? error;
  List<CompletedProjectData>? data;

  CompletedProjectResponse({this.message, this.error, this.data});

  CompletedProjectResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CompletedProjectData>[];
      json['data'].forEach((v) {
        data!.add(new CompletedProjectData.fromJson(v));
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

class CompletedProjectData {
  String? employeeName;
  int? employeeId;
  String? department;
  String? projectName;
  String? assignedStartDate;
  String? assignedEndDate;
  String? startDate;
  String? endDate;
  String? projectUpdate;

  CompletedProjectData(
      {this.employeeName,
      this.employeeId,
      this.department,
      this.projectName,
      this.assignedStartDate,
      this.assignedEndDate,
      this.startDate,
      this.endDate,
      this.projectUpdate});

  CompletedProjectData.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    employeeId = json['EmployeeId'];
    department = json['Department'];
    projectName = json['ProjectName'];
    assignedStartDate = json['AssignedStartDate'];
    assignedEndDate = json['AssignedEndDate'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    projectUpdate = json['projectUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeName'] = this.employeeName;
    data['EmployeeId'] = this.employeeId;
    data['Department'] = this.department;
    data['ProjectName'] = this.projectName;
    data['AssignedStartDate'] = this.assignedStartDate;
    data['AssignedEndDate'] = this.assignedEndDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['projectUpdate'] = this.projectUpdate;
    return data;
  }
}

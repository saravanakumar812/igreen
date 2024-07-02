class WaitingForApprovalList {
  String? message;
  bool? error;
  List<ReviewApprovalData>? data;

  WaitingForApprovalList({this.message, this.error, this.data});

  WaitingForApprovalList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <ReviewApprovalData>[];
      json['data'].forEach((v) {
        data!.add(new ReviewApprovalData.fromJson(v));
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

class ReviewApprovalData {
  String? employeeName;
  int? departmentId;
  int? employeeId;
  String? department;
  int? projectId;
  String? projectName;
  String? assignedStartDate;
  String? assignedEndDate;
  String? startDate;
  String? endDate;
  String? projectUpdate;

  ReviewApprovalData(
      {this.employeeName,
        this.departmentId,
        this.employeeId,
        this.department,
        this.projectId,
        this.projectName,
        this.assignedStartDate,
        this.assignedEndDate,
        this.startDate,
        this.endDate,
        this.projectUpdate});

  ReviewApprovalData.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    departmentId = json['DepartmentId'];
    employeeId = json['EmployeeId'];
    department = json['Department'];
    projectId = json['ProjectId'];
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
    data['DepartmentId'] = this.departmentId;
    data['EmployeeId'] = this.employeeId;
    data['Department'] = this.department;
    data['ProjectId'] = this.projectId;
    data['ProjectName'] = this.projectName;
    data['AssignedStartDate'] = this.assignedStartDate;
    data['AssignedEndDate'] = this.assignedEndDate;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['projectUpdate'] = this.projectUpdate;
    return data;
  }
}
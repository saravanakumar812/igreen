class GetAttendanceListResponse {
  String? message;
  bool? error;
  List<Attendance>? attendance;
  List<AttendanceCount>? attendanceCount;

  GetAttendanceListResponse(
      {this.message, this.error, this.attendance, this.attendanceCount});

  GetAttendanceListResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
    if (json['attendanceCount'] != null) {
      attendanceCount = <AttendanceCount>[];
      json['attendanceCount'].forEach((v) {
        attendanceCount!.add(new AttendanceCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    if (this.attendanceCount != null) {
      data['attendanceCount'] =
          this.attendanceCount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  int? employeeId;
  int? attendanceId;
  String? profileName;
  String? profileImage;
  String? attendanceDate;
  String? startTime;
  String? endTime;
  int? attendanceApproval;

  Attendance(
      {this.employeeId,
      this.attendanceId,
      this.profileName,
      this.profileImage,
      this.attendanceDate,
      this.startTime,
      this.endTime,
      this.attendanceApproval});

  Attendance.fromJson(Map<String, dynamic> json) {
    employeeId = json['EmployeeId'];
    attendanceId = json['AttendanceId'];
    profileName = json['ProfileName'];
    profileImage = json['ProfileImage'];
    attendanceDate = json['AttendanceDate'];
    startTime = json['StartTime'];
    endTime = json['EndTime'];
    attendanceApproval = json['AttendanceApproval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeId'] = this.employeeId;
    data['AttendanceId'] = this.attendanceId;
    data['ProfileName'] = this.profileName;
    data['ProfileImage'] = this.profileImage;
    data['AttendanceDate'] = this.attendanceDate;
    data['StartTime'] = this.startTime;
    data['EndTime'] = this.endTime;
    data['AttendanceApproval'] = this.attendanceApproval;
    return data;
  }
}

class AttendanceCount {
  int? completed;
  int? pending;

  AttendanceCount({this.completed, this.pending});

  AttendanceCount.fromJson(Map<String, dynamic> json) {
    completed = json['Completed'];
    pending = json['Pending'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Completed'] = this.completed;
    data['Pending'] = this.pending;
    return data;
  }
}

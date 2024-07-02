class AttendanceResponse {
  String? message;
  bool? error;
  String? attendanceId;

  AttendanceResponse({this.message, this.error, this.attendanceId});

  AttendanceResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    attendanceId = json['AttendanceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['error'] = this.error;
    data['AttendanceId'] = this.attendanceId;
    return data;
  }
}

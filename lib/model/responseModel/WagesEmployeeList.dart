class WagesEmployeeList {
String? employeeName;
String? amount;
String? fingerPrint;
String? photo;
String? contactNumber;

WagesEmployeeList({this.employeeName, this.amount, this.fingerPrint, this.photo, this.contactNumber});

WagesEmployeeList.fromJson(Map<String, dynamic> json) {
employeeName = json['EmployeeName'];
amount = json['Amount'];
fingerPrint = json['FingerPrint'];
photo = json['Photo'];
contactNumber = json['ContactNumber'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['EmployeeName'] = this.employeeName;
data['Amount'] = this.amount;
data['FingerPrint'] = this.fingerPrint;
data['Photo'] = this.photo;
data['ContactNumber'] = this.contactNumber;
return data;
}
}
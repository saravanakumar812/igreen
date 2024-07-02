class MaintenanceResponseList {
String? checklistName;
String? checklistStatus;

MaintenanceResponseList({this.checklistName, this.checklistStatus});

MaintenanceResponseList.fromJson(Map<String, dynamic> json) {
checklistName = json['checklistName'];
checklistStatus = json['checklistStatus'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['checklistName'] = this.checklistName;
data['checklistStatus'] = this.checklistStatus;
return data;
}
}
class SizeList {
  String? message;
  bool? error;
  List<SizeData>? data;

  SizeList({this.message, this.error, this.data});

  SizeList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SizeData>[];
      json['data'].forEach((v) {
        data!.add(new SizeData.fromJson(v));
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

class SizeData {
  int? id;
  String? size;

  SizeData({this.id, this.size});

  SizeData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    size = json['Size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Size'] = this.size;
    return data;
  }
}
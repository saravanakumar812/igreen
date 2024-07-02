class GetCityData {
  String? message;
  bool? error;
  List<CityData>? data;

  GetCityData({this.message, this.error, this.data});

  GetCityData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(new CityData.fromJson(v));
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

class CityData {
  String? cityName;

  CityData({this.cityName});

  CityData.fromJson(Map<String, dynamic> json) {
    cityName = json['CityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CityName'] = this.cityName;
    return data;
  }
}

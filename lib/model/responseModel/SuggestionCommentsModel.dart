class SuggestionCommentsModel {
  String? message;
  bool? error;
  List<SuggestionData>? data;

  SuggestionCommentsModel({this.message, this.error, this.data});

  SuggestionCommentsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['data'] != null) {
      data = <SuggestionData>[];
      json['data'].forEach((v) {
        data!.add(new SuggestionData.fromJson(v));
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

class SuggestionData {
  String? suggestion;

  SuggestionData({this.suggestion});

  SuggestionData.fromJson(Map<String, dynamic> json) {
    suggestion = json['suggestion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suggestion'] = this.suggestion;
    return data;
  }
}
class HomeGraphModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  HomeGraphModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  HomeGraphModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    return data;
  }
}

class Data {
  String? country;
  int? countryCount;

  Data({this.country, this.countryCount});

  Data.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    countryCount = json['country_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country'] = this.country;
    data['country_count'] = this.countryCount;
    return data;
  }
}

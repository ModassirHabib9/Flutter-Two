class CurrenciesModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  Null? error;

  CurrenciesModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  CurrenciesModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? type;
  String? name;
  String? symbol;
  String? rate;
  String? logo;

  Data({this.id, this.type, this.name, this.symbol, this.rate, this.logo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    symbol = json['symbol'];
    rate = json['rate'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['rate'] = this.rate;
    data['logo'] = this.logo;
    return data;
  }
}

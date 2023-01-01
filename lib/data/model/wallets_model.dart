import 'dart:core';


class WalletsModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  WalletsModel({this.status, this.statusCode, this.message, this.data, this.error});

  WalletsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) { data!.add(new Data.fromJson(v)); });
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
  int? userId;
  String? accountAddress;
  int? currencyId;
  String? balance;
  String? isDefault;
  String? createdAt;
  String? updatedAt;
  Currencies? currencies;

  Data({this.id, this.userId, this.accountAddress, this.currencyId, this.balance, this.isDefault, this.createdAt, this.updatedAt, this.currencies});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    accountAddress = json['account_address'];
    currencyId = json['currency_id'];
    balance = json['balance'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currencies = json['currencies'] != null ? new Currencies.fromJson(json['currencies']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['account_address'] = this.accountAddress;
    data['currency_id'] = this.currencyId;
    data['balance'] = this.balance;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.currencies != null) {
      data['currencies'] = this.currencies!.toJson();
    }
    return data;
  }
}

class Currencies {
  int? id;
  String? type;
  String? name;
  String? symbol;
  String? code;
  String? defalut;
  String? rate;
  String? logo;
  String? exchangeFrom;
  String? allowAddressCreation;
  String? status;
  String? createdAt;
  String? updatedAt;

  Currencies({this.id, this.type, this.name, this.symbol, this.code, this.rate, this.logo, this.defalut, this.exchangeFrom, this.allowAddressCreation, this.status, this.createdAt, this.updatedAt});

Currencies.fromJson(Map<String, dynamic> json) {
id = json['id'];
type = json['type'];
name = json['name'];
symbol = json['symbol'];
code = json['code'];
rate = json['rate'];
logo = json['logo'];
defalut = json['default'];
exchangeFrom = json['exchange_from'];
allowAddressCreation = json['allow_address_creation'];
status = json['status'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['type'] = this.type;
  data['name'] = this.name;
  data['symbol'] = this.symbol;
  data['code'] = this.code;
  data['rate'] = this.rate;
  data['logo'] = this.logo;
  data['default'] = this.defalut;
  data['exchange_from'] = this.exchangeFrom;
  data['allow_address_creation'] = this.allowAddressCreation;
  data['status'] = this.status;
  data['created_at'] = this.createdAt;
  data['updated_at'] = this.updatedAt;
  return data;
}
}

class GetWalletModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  GetWalletModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  GetWalletModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? accountAddress;
  int? currencyId;
  String? balance;
  String? isDefault;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.accountAddress,
      this.currencyId,
      this.balance,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    accountAddress = json['account_address'];
    currencyId = json['currency_id'];
    balance = json['balance'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return data;
  }
}

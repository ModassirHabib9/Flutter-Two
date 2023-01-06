class RecentTransactionsModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  RecentTransactionsModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  RecentTransactionsModel.fromJson(Map<String, dynamic> json) {
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
  int? endUserId;
  String? fromAccount;
  String? toAccount;
  String? currencyId;
  String? paymentMethodId;
  String? merchantId;
  String? bankId;
  String? fileId;
  String? refundReference;
  int? transactionReferenceId;
  String? transactionTypeId;
  String? userType;
  String? email;
  String? phone;
  String? subtotal;
  String? percentage;
  String? chargePercentage;
  String? chargeFixed;
  String? total;
  String? note;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.endUserId,
        this.fromAccount,
        this.toAccount,
        this.currencyId,
        this.paymentMethodId,
        this.merchantId,
        this.bankId,
        this.fileId,
        this.refundReference,
        this.transactionReferenceId,
        this.transactionTypeId,
        this.userType,
        this.email,
        this.phone,
        this.subtotal,
        this.percentage,
        this.chargePercentage,
        this.chargeFixed,
        this.total,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    endUserId = json['end_user_id'];
    fromAccount = json['from_account'];
    toAccount = json['to_account'];
    currencyId = json['currency_id'];
    paymentMethodId = json['payment_method_id'];
    merchantId = json['merchant_id'];
    bankId = json['bank_id'];
    fileId = json['file_id'];
    refundReference = json['refund_reference'];
    transactionReferenceId = json['transaction_reference_id'];
    transactionTypeId = json['transaction_type_id'];
    userType = json['user_type'];
    email = json['email'];
    phone = json['phone'];
    subtotal = json['subtotal'];
    percentage = json['percentage'];
    chargePercentage = json['charge_percentage'];
    chargeFixed = json['charge_fixed'];
    total = json['total'];
    note = json['note'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['end_user_id'] = this.endUserId;
    data['from_account'] = this.fromAccount;
    data['to_account'] = this.toAccount;
    data['currency_id'] = this.currencyId;
    data['payment_method_id'] = this.paymentMethodId;
    data['merchant_id'] = this.merchantId;
    data['bank_id'] = this.bankId;
    data['file_id'] = this.fileId;
    data['refund_reference'] = this.refundReference;
    data['transaction_reference_id'] = this.transactionReferenceId;
    data['transaction_type_id'] = this.transactionTypeId;
    data['user_type'] = this.userType;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['subtotal'] = this.subtotal;
    data['percentage'] = this.percentage;
    data['charge_percentage'] = this.chargePercentage;
    data['charge_fixed'] = this.chargeFixed;
    data['total'] = this.total;
    data['note'] = this.note;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

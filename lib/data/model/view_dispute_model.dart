class ViewDisputeModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  ViewDisputeModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  ViewDisputeModel.fromJson(Map<String, dynamic> json) {
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
  String? claimantId;
  String? defendantId;
  String? transactionId;
  String? reasonId;
  String? type;
  String? title;
  String? description;
  String? code;
  String? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.claimantId,
      this.defendantId,
      this.transactionId,
      this.reasonId,
      this.type,
      this.title,
      this.description,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    claimantId = json['claimant_id'];
    defendantId = json['defendant_id'];
    transactionId = json['transaction_id'];
    reasonId = json['reason_id'];
    type = json['type'];
    title = json['title'];
    description = json['description'];
    code = json['code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['claimant_id'] = this.claimantId;
    data['defendant_id'] = this.defendantId;
    data['transaction_id'] = this.transactionId;
    data['reason_id'] = this.reasonId;
    data['type'] = this.type;
    data['title'] = this.title;
    data['description'] = this.description;
    data['code'] = this.code;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

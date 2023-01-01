class ViewTicketModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  ViewTicketModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  ViewTicketModel.fromJson(Map<String, dynamic> json) {
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
  String? adminId;
  String? ticketStatusId;
  String? subject;
  String? message;
  String? code;
  String? priority;
  String? lastReply;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.adminId,
      this.ticketStatusId,
      this.subject,
      this.message,
      this.code,
      this.priority,
      this.lastReply,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    adminId = json['admin_id'];
    ticketStatusId = json['ticket_status_id'];
    subject = json['subject'];
    message = json['message'];
    code = json['code'];
    priority = json['priority'];
    lastReply = json['last_reply'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['admin_id'] = this.adminId;
    data['ticket_status_id'] = this.ticketStatusId;
    data['subject'] = this.subject;
    data['message'] = this.message;
    data['code'] = this.code;
    data['priority'] = this.priority;
    data['last_reply'] = this.lastReply;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SettingActivityModel {
  String? status;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? error;

  SettingActivityModel(
      {this.status, this.statusCode, this.message, this.data, this.error});

  SettingActivityModel.fromJson(Map<String, dynamic> json) {
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
  String? type;
  String? activityType;
  String? ipAddress;
  String? source;
  String? location;
  String? browserAgent;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.userId,
      this.type,
      this.activityType,
      this.ipAddress,
      this.source,
      this.location,
      this.browserAgent,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    type = json['type'];
    activityType = json['activity_type'];
    ipAddress = json['ip_address'];
    source = json['source'];
    location = json['location'];
    browserAgent = json['browser_agent'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['activity_type'] = this.activityType;
    data['ip_address'] = this.ipAddress;
    data['source'] = this.source;
    data['location'] = this.location;
    data['browser_agent'] = this.browserAgent;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

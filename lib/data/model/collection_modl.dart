class collection_modl {
  Info? info;
  List<Item>? item;

  collection_modl({this.info, this.item});

  collection_modl.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(new Item.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.item != null) {
      data['item'] = this.item!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  String? sPostmanId;
  String? name;
  String? schema;

  Info({this.sPostmanId, this.name, this.schema});

  Info.fromJson(Map<String, dynamic> json) {
    sPostmanId = json['_postman_id'];
    name = json['name'];
    schema = json['schema'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_postman_id'] = this.sPostmanId;
    data['name'] = this.name;
    data['schema'] = this.schema;
    return data;
  }
}

class Item {
  String? name;
  String? id;
  Request? request;
  List<Null>? response;
  ProtocolProfileBehavior? protocolProfileBehavior;

  Item(
      {this.name,
      this.id,
      this.request,
      this.response,
      this.protocolProfileBehavior});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
    if (json['response'] != null) {
      response = <Null>[];
      json['response'].forEach((v) {
        /*   response!.add(new Null.fromJson(v));*/
      });
    }
    protocolProfileBehavior = json['protocolProfileBehavior'] != null
        ? new ProtocolProfileBehavior.fromJson(json['protocolProfileBehavior'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toString()).toList();
    }
    if (this.protocolProfileBehavior != null) {
      data['protocolProfileBehavior'] = this.protocolProfileBehavior!.toJson();
    }
    return data;
  }
}

class Request {
  String? method;
  List<Header>? header;
  Body? body;
  String? url;

  Request({this.method, this.header, this.body, this.url});

  Request.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    if (json['header'] != null) {
      header = <Header>[];
      json['header'].forEach((v) {
        header!.add(new Header.fromJson(v));
      });
    }
    body = json['body'] != null ? new Body.fromJson(json['body']) : null;
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    if (this.header != null) {
      data['header'] = this.header!.map((v) => v.toJson()).toList();
    }
    if (this.body != null) {
      data['body'] = this.body!.toJson();
    }
    data['url'] = this.url;
    return data;
  }
}

class Header {
  String? key;
  String? value;
  String? type;

  Header({this.key, this.value, this.type});

  Header.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['type'] = this.type;
    return data;
  }
}

class Body {
  String? mode;
  List<Urlencoded>? urlencoded;

  Body({this.mode, this.urlencoded});

  Body.fromJson(Map<String, dynamic> json) {
    mode = json['mode'];
    if (json['urlencoded'] != null) {
      urlencoded = <Urlencoded>[];
      json['urlencoded'].forEach((v) {
        urlencoded!.add(new Urlencoded.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mode'] = this.mode;
    if (this.urlencoded != null) {
      data['urlencoded'] = this.urlencoded!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Urlencoded {
  String? key;
  String? value;
  String? type;
  bool? disabled;

  Urlencoded({this.key, this.value, this.type, this.disabled});

  Urlencoded.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
    type = json['type'];
    disabled = json['disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    data['type'] = this.type;
    data['disabled'] = this.disabled;
    return data;
  }
}

class ProtocolProfileBehavior {
  bool? disableBodyPruning;

  ProtocolProfileBehavior({this.disableBodyPruning});

  ProtocolProfileBehavior.fromJson(Map<String, dynamic> json) {
    disableBodyPruning = json['disableBodyPruning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['disableBodyPruning'] = this.disableBodyPruning;
    return data;
  }
}

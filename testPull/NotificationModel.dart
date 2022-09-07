class NotificationModel {
  bool? status;
  int? statusCode;
  String? message;
  Data? data;

  NotificationModel({this.status, this.statusCode, this.message, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Items>? items;
  Meta? meta;

  Data({this.items, this.meta});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class Items {
  int? id;
  int? agentProfileId;
  String? shortTitle;
  String? notificationType;
  String? message;
  bool? isReaded;
  Null? deletedAt;

  Items(
      {this.id,
        this.agentProfileId,
        this.shortTitle,
        this.notificationType,
        this.message,
        this.isReaded,
        this.deletedAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agentProfileId = json['agentProfileId'];
    shortTitle = json['shortTitle'];
    notificationType = json['notificationType'];
    message = json['message'];
    isReaded = json['isReaded'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agentProfileId'] = this.agentProfileId;
    data['shortTitle'] = this.shortTitle;
    data['notificationType'] = this.notificationType;
    data['message'] = this.message;
    data['isReaded'] = this.isReaded;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class Meta {
  int? totalItems;
  int? itemCount;
  int? itemsPerPage;
  int? totalPages;
  int? currentPage;

  Meta(
      {this.totalItems,
        this.itemCount,
        this.itemsPerPage,
        this.totalPages,
        this.currentPage});

  Meta.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = this.totalItems;
    data['itemCount'] = this.itemCount;
    data['itemsPerPage'] = this.itemsPerPage;
    data['totalPages'] = this.totalPages;
    data['currentPage'] = this.currentPage;
    return data;
  }
}

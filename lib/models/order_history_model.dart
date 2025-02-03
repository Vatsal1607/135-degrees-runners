class OrderHistoryModel {
  bool? success;
  int? statusCode;
  String? message;
  Data? data;

  OrderHistoryModel({this.success, this.statusCode, this.message, this.data});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<OrderHistory>? orderHistory;
  int? totalOrders;

  Data({this.orderHistory, this.totalOrders});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['orderHistory'] != null) {
      orderHistory = <OrderHistory>[];
      json['orderHistory'].forEach((v) {
        orderHistory!.add(OrderHistory.fromJson(v));
      });
    }
    totalOrders = json['totalOrders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orderHistory != null) {
      data['orderHistory'] = orderHistory!.map((v) => v.toJson()).toList();
    }
    data['totalOrders'] = totalOrders;
    return data;
  }
}

class OrderHistory {
  String? deliveryStartTime;
  String? deliveryEndTime;
  String? status;
  String? updatedAt;
  String? sId;
  int? totalAmount;
  String? deliveryAddress;
  String? orderStatus;
  String? acceptedAt;
  String? createdAt;
  int? orderIds;
  List<Items>? items;
  String? businessName;
  String? userFirstName;
  String? userLastName;

  OrderHistory(
      {this.deliveryStartTime,
      this.deliveryEndTime,
      this.status,
      this.updatedAt,
      this.sId,
      this.totalAmount,
      this.deliveryAddress,
      this.orderStatus,
      this.acceptedAt,
      this.createdAt,
      this.orderIds,
      this.items,
      this.businessName,
      this.userFirstName,
      this.userLastName});

  OrderHistory.fromJson(Map<String, dynamic> json) {
    deliveryStartTime = json['deliveryStartTime'];
    deliveryEndTime = json['deliveryEndTime'];
    status = json['status'];
    updatedAt = json['updatedAt'];
    sId = json['_id'];
    totalAmount = json['totalAmount'];
    deliveryAddress = json['deliveryAddress'];
    orderStatus = json['orderStatus'];
    acceptedAt = json['acceptedAt'];
    createdAt = json['createdAt'];
    orderIds = json['orderIds'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    businessName = json['businessName'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deliveryStartTime'] = deliveryStartTime;
    data['deliveryEndTime'] = deliveryEndTime;
    data['status'] = status;
    data['updatedAt'] = updatedAt;
    data['_id'] = sId;
    data['totalAmount'] = totalAmount;
    data['deliveryAddress'] = deliveryAddress;
    data['orderStatus'] = orderStatus;
    data['acceptedAt'] = acceptedAt;
    data['createdAt'] = createdAt;
    data['orderIds'] = orderIds;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['businessName'] = businessName;
    data['userFirstName'] = userFirstName;
    data['userLastName'] = userLastName;
    return data;
  }
}

class Items {
  String? menuId;
  String? itemName;
  int? quantity;
  int? price;
  Size? size;

  Items({this.menuId, this.itemName, this.quantity, this.price, this.size});

  Items.fromJson(Map<String, dynamic> json) {
    menuId = json['menuId'];
    itemName = json['itemName'];
    quantity = json['quantity'];
    price = json['price'];
    size = json['size'] != null ? Size.fromJson(json['size']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menuId'] = menuId;
    data['itemName'] = itemName;
    data['quantity'] = quantity;
    data['price'] = price;
    if (size != null) {
      data['size'] = size!.toJson();
    }
    return data;
  }
}

class Size {
  String? sizeId;
  String? sizeName;

  Size({this.sizeId, this.sizeName});

  Size.fromJson(Map<String, dynamic> json) {
    sizeId = json['sizeId'];
    sizeName = json['sizeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sizeId'] = sizeId;
    data['sizeName'] = sizeName;
    return data;
  }
}

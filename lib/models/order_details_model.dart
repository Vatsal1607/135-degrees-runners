class OrderDetailsModel {
  String? message;
  List<OrderDetailsData>? data;

  OrderDetailsModel({this.message, this.data});

  OrderDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <OrderDetailsData>[];
      json['data'].forEach((v) {
        data!.add(OrderDetailsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetailsData {
  String? sId;
  List<Items>? items;
  int? totalAmount;
  String? orderStatus;
  String? deliveryAddress;
  int? orderIds;
  String? acceptedAt;
  String? createdAt;
  String? businessName;
  int? businessPhone;
  String? userFirstName;
  String? userLastName;
  String? userPhone;
  String? pickupStartTime;
  String? pickupEndTime;
  String? deliveryStartTime;
  String? deliveryEndTime;

  OrderDetailsData(
      {this.sId,
      this.items,
      this.totalAmount,
      this.orderStatus,
      this.deliveryAddress,
      this.orderIds,
      this.acceptedAt,
      this.createdAt,
      this.businessName,
      this.businessPhone,
      this.userFirstName,
      this.userLastName,
      this.userPhone,
      this.pickupStartTime,
      this.pickupEndTime,
      this.deliveryStartTime,
      this.deliveryEndTime});

  OrderDetailsData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    totalAmount = json['totalAmount'];
    orderStatus = json['orderStatus'];
    deliveryAddress = json['deliveryAddress'];
    orderIds = json['orderIds'];
    acceptedAt = json['acceptedAt'];
    createdAt = json['createdAt'];
    businessName = json['businessName'];
    businessPhone = json['businessPhone'];
    userFirstName = json['userFirstName'];
    userLastName = json['userLastName'];
    userPhone = json['userPhone'];
    pickupStartTime = json['pickupStartTime'];
    pickupEndTime = json['pickupEndTime'];
    deliveryStartTime = json['deliveryStartTime'];
    deliveryEndTime = json['deliveryEndTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['totalAmount'] = totalAmount;
    data['orderStatus'] = orderStatus;
    data['deliveryAddress'] = deliveryAddress;
    data['orderIds'] = orderIds;
    data['acceptedAt'] = acceptedAt;
    data['createdAt'] = createdAt;
    data['businessName'] = businessName;
    data['businessPhone'] = businessPhone;
    data['userFirstName'] = userFirstName;
    data['userLastName'] = userLastName;
    data['userPhone'] = userPhone;
    data['pickupStartTime'] = pickupStartTime;
    data['pickupEndTime'] = pickupEndTime;
    data['deliveryStartTime'] = deliveryStartTime;
    data['deliveryEndTime'] = deliveryEndTime;
    return data;
  }
}

class Items {
  String? menuId;
  String? itemName;
  int? quantity;
  int? price;
  Size? size;

  Items({
    this.menuId,
    this.itemName,
    this.quantity,
    this.price,
    this.size,
  });

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

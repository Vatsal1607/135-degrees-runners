class AcceptedOrderModel {
  final String id;
  final String orderId;
  final String deliveryBoyId;
  final DateTime? pickupStartTime;
  final DateTime? pickupEndTime;
  final DateTime? deliveryStartTime;
  final DateTime? deliveryEndTime;
  final String status;
  final DateTime updatedAt;
  final OrderDetails orderDetails;

  AcceptedOrderModel({
    required this.id,
    required this.orderId,
    required this.deliveryBoyId,
    this.pickupStartTime,
    this.pickupEndTime,
    this.deliveryStartTime,
    this.deliveryEndTime,
    required this.status,
    required this.updatedAt,
    required this.orderDetails,
  });

  factory AcceptedOrderModel.fromJson(Map<String, dynamic> json) {
    return AcceptedOrderModel(
      id: json['_id'],
      orderId: json['orderId'],
      deliveryBoyId: json['deliveryBoyId'],
      pickupStartTime: json['pickupStartTime'] != null
          ? DateTime.parse(json['pickupStartTime'])
          : null,
      pickupEndTime: json['pickupEndTime'] != null
          ? DateTime.parse(json['pickupEndTime'])
          : null,
      deliveryStartTime: json['deliveryStartTime'] != null
          ? DateTime.parse(json['deliveryStartTime'])
          : null,
      deliveryEndTime: json['deliveryEndTime'] != null
          ? DateTime.parse(json['deliveryEndTime'])
          : null,
      status: json['status'],
      updatedAt: DateTime.parse(json['updatedAt']),
      orderDetails: OrderDetails.fromJson(json['orderDetails']),
    );
  }
}

class OrderDetails {
  final List<Item> items;
  final double totalAmount;
  final String orderStatus;
  final String deliveryAddress;
  final int orderIds;

  OrderDetails({
    required this.items,
    required this.totalAmount,
    required this.orderStatus,
    required this.deliveryAddress,
    required this.orderIds,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<Item> items =
        itemsList.map((itemJson) => Item.fromJson(itemJson)).toList();

    return OrderDetails(
      items: items,
      totalAmount: json['totalAmount'].toDouble(),
      orderStatus: json['orderStatus'],
      deliveryAddress: json['deliveryAddress'],
      orderIds: json['orderIds'],
    );
  }
}

class Item {
  final String menuId;
  final String itemName;
  final int quantity;
  final double price;

  Item({
    required this.menuId,
    required this.itemName,
    required this.quantity,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      menuId: json['menuId'],
      itemName: json['itemName'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }
}


// OLD model
// class AcceptedOrderModel {
//   final String id;
//   final String orderId;
//   final String deliveryBoyId;
//   final DateTime? pickupStartTime;
//   final DateTime? pickupEndTime;
//   final DateTime? deliveryStartTime;
//   final DateTime? deliveryEndTime;
//   final String status;
//   final DateTime updatedAt;
//   final OrderDetails orderDetails;

//   AcceptedOrderModel({
//     required this.id,
//     required this.orderId,
//     required this.deliveryBoyId,
//     this.pickupStartTime,
//     this.pickupEndTime,
//     this.deliveryStartTime,
//     this.deliveryEndTime,
//     required this.status,
//     required this.updatedAt,
//     required this.orderDetails,
//   });

//   factory AcceptedOrderModel.fromJson(Map<String, dynamic> json) {
//     return AcceptedOrderModel(
//       id: json['_id'],
//       orderId: json['orderId'],
//       deliveryBoyId: json['deliveryBoyId'],
//       pickupStartTime: json['pickupStartTime'] != null
//           ? DateTime.parse(json['pickupStartTime'])
//           : null,
//       pickupEndTime: json['pickupEndTime'] != null
//           ? DateTime.parse(json['pickupEndTime'])
//           : null,
//       deliveryStartTime: json['deliveryStartTime'] != null
//           ? DateTime.parse(json['deliveryStartTime'])
//           : null,
//       deliveryEndTime: json['deliveryEndTime'] != null
//           ? DateTime.parse(json['deliveryEndTime'])
//           : null,
//       status: json['status'],
//       updatedAt: DateTime.parse(json['updatedAt']),
//       orderDetails: OrderDetails.fromJson(json['orderDetails']),
//     );
//   }
// }

// class OrderDetails {
//   final List<Item> items;
//   final double totalAmount;
//   final String orderStatus;
//   final String deliveryAddress;

//   OrderDetails({
//     required this.items,
//     required this.totalAmount,
//     required this.orderStatus,
//     required this.deliveryAddress,
//   });

//   factory OrderDetails.fromJson(Map<String, dynamic> json) {
//     var itemsList = json['items'] as List;
//     List<Item> items =
//         itemsList.map((itemJson) => Item.fromJson(itemJson)).toList();

//     return OrderDetails(
//       items: items,
//       totalAmount: json['totalAmount'].toDouble(),
//       orderStatus: json['orderStatus'],
//       deliveryAddress: json['deliveryAddress'],
//     );
//   }
// }

// class Item {
//   final String menuId;
//   final String itemName;
//   final double price;

//   Item({
//     required this.menuId,
//     required this.itemName,
//     required this.price,
//   });

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       menuId: json['menuId'],
//       itemName: json['itemName'],
//       price: json['price'].toDouble(),
//     );
//   }
// }

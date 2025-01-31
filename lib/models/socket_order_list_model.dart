class SocketOrderModel {
  final String id;
  final List<Item> items;
  final num totalAmount;
  final String orderStatus;
  final String deliveryAddress;
  final int orderIds; // Adjusted to match the response field
  final DateTime acceptedAt;
  final DateTime createdAt;
  final String businessName;
  final String userFirstName;
  final String userLastName;
  final Map<String, dynamic> sizeDetails; // Added to match the response

  SocketOrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.orderStatus,
    required this.deliveryAddress,
    required this.orderIds, // Include in constructor
    required this.acceptedAt,
    required this.createdAt,
    required this.businessName,
    required this.userFirstName,
    required this.userLastName,
    required this.sizeDetails, // Include in constructor
  });

  factory SocketOrderModel.fromJson(Map<String, dynamic> json) {
    var itemsList = json['items'] as List;
    List<Item> items =
        itemsList.map((itemJson) => Item.fromJson(itemJson)).toList();

    return SocketOrderModel(
      id: json['_id'],
      items: items,
      totalAmount: json['totalAmount'],
      orderStatus: json['orderStatus'],
      deliveryAddress: json['deliveryAddress'],
      orderIds: json['orderIds'], // Map to orderIds field
      acceptedAt: DateTime.parse(json['acceptedAt']),
      createdAt: DateTime.parse(json['createdAt']),
      businessName: json['businessName'],
      userFirstName: json['userFirstName'] ?? '',
      userLastName: json['userLastName'] ?? '',
      sizeDetails: json['sizeDetails'] ?? {}, // Safely handle sizeDetails
    );
  }
}

class Item {
  String? menuId;
  String? itemName;
  int? quantity;
  int? price;
  Size? size;

  Item({
    this.menuId,
    this.itemName,
    this.quantity,
    this.price,
    this.size,
  });

  Item.fromJson(Map<String, dynamic> json) {
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

// OLD
// class Item {
//   final String menuId;
//   final String itemName;
//   final num price;
//   final int quantity; // Added quantity field

//   Item({
//     required this.menuId,
//     required this.itemName,
//     required this.price,
//     required this.quantity, // Include quantity in constructor
//   });

//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       menuId: json['menuId'],
//       itemName: json['itemName'],
//       price: json['price'],
//       quantity: json['quantity'], // Handle quantity in item model
//     );
//   }
// }

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

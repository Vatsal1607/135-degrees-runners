import 'dart:developer';
import 'package:flutter/material.dart';
import '../../core/constants/keys.dart';
import '../../models/order_details_model.dart';
import '../../services/socket/socket_service.dart';

class OrderDetailsProvider extends ChangeNotifier {
  OrderDetailsData? orderDetailsData;
  int totalQuantity = 0;

  bool isLoading = false;
  void emitAndListenOrderDetails(SocketService socketService, String orderId) {
    isLoading = true;
    // Emit event
    socketService.emitEvent(SocketEvents.orderDetails, {
      'orderId': orderId,
    });

    /// Listen for event
    socketService.listenToEvent(SocketEvents.orderDetailsResponse, (data) {
      try {
        log('Raw socket OrderDetails data: $data');

        final List<dynamic> dataList = data['data'] ?? [];
        if (dataList.isNotEmpty) {
          final orderData = OrderDetailsModel.fromJson(
              {'data': dataList}); // Ensure full JSON structure
          orderDetailsData = orderData.data?.first; // Use .first instead of [0]

          totalQuantity = orderDetailsData?.items != null
              ? orderDetailsData!.items!
                  .fold(0, (sum, item) => sum + (item.quantity ?? 0))
              : 0;
        } else {
          debugPrint('No data found for order');
        }
        isLoading = false;
        notifyListeners();
      } catch (e) {
        isLoading = false;
        notifyListeners();
        log('Error parsing socket data orderDetailsResponse: $e');
      }
    });
  }
}

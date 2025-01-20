import 'dart:async';
import 'dart:developer';
import 'package:degrees_runners/core/constants/keys.dart';
import 'package:degrees_runners/services/local/shared_preferences_service.dart';
import 'package:flutter/material.dart';
import '../../../models/socket_order_list_model.dart';
import '../../../services/socket/socket_service.dart';

class AcceptedOrderProvider extends ChangeNotifier {
  bool isActive = false;
  final SocketService socketService = SocketService();

  AcceptedOrderProvider() {
    onSocketConnected(); // ! EMIT & LISTEN acceptedOrderList
  }

  List<SocketOrderModel>? acceptedOrderList;

  // bool isLoading = false;

  void onSocketConnected() {
    // Timer to emit the event every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // Emit the 'acceptedOrderList' event
      socketService.emitEvent(SocketEvents.acceptedOrderList, {
        'deliveryBoyId': sharedPrefsService.getString(SharedPrefsKeys.userId),
      });
    });

    /// Listen for the 'acceptedListResponse' event
    socketService.listenToEvent(SocketEvents.acceptedListResponse, (data) {
      try {
        log('Raw socket acceptedListResponse data: $data');
        Map<String, dynamic> response = data;
        var orderListData = response['data'] as List;
        if (orderListData.isNotEmpty) {
          // Clear and reinitialize the list to ensure data is fresh
          acceptedOrderList?.clear();
          List<SocketOrderModel> orders = orderListData
              .map((orderJson) => SocketOrderModel.fromJson(orderJson))
              .toList();
          // Update your UI or state with the parsed data
          acceptedOrderList = orders;
        } else {
          // If no items, ensure the list is cleared
          acceptedOrderList?.clear();
        }
        notifyListeners();
      } catch (e) {
        log('Error parsing socket data: $e');
      }
    });
  }

  // @override
  // void dispose() {
  //   socketService.disconnect();
  //   super.dispose();
  // }
}

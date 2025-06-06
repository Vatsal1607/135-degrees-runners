import 'dart:async';
import 'dart:developer';
import 'package:degrees_runners/core/constants/keys.dart';
import 'package:degrees_runners/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../models/api_global_model.dart';
import '../../../models/socket_order_list_model.dart';
import '../../../services/network/api_service.dart';
import '../../../services/socket/socket_service.dart';

class OrderProvider extends ChangeNotifier {
  bool isActive = false;
  final SocketService socketService = SocketService();

  // * Toggle Active Status
  onChangeIsActive(bool? confirmed, bool newValue) {
    if (confirmed == true) {
      isActive = newValue;

      if (isActive) {
        // * Connect to socket server
        socketService.connectToSocket();
        socketService.socket.onConnect((_) {
          //* user connect by database
          final userConnectData = {
            "userId": sharedPrefsService.getString(SharedPrefsKeys.userId),
            "deviceId": sharedPrefsService.getString(SharedPrefsKeys.deviceId),
            "role": "4",
            "socketId": socketService.socket.id,
          };
          socketService.emitEvent(SocketEvents.userConnected, userConnectData);
          onSocketConnected(); // ! EMIT & LISTEN OrderList
        });
        deliveryStatus(isActive: true); //* API
      } else {
        // * Disconnect from socket server
        socketService.disconnect();
        deliveryStatus(isActive: false); //* API
      }
      notifyListeners();
    }
  }

  List<SocketOrderModel>? orderList;

  Timer? _orderListTimer;
  void onSocketConnected() {
    emitAndListenOrderList();
  }

  bool _isOrderListListenerActive = false;

  void emitAndListenOrderList() {
    _orderListTimer?.cancel();

    _orderListTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      socketService.emitEvent(SocketEvents.orderList, {});
    });

    // Start listening to 'order-list-response' only once
    if (!_isOrderListListenerActive) {
      socketService.listenToEvent(SocketEvents.orderListResponse, (data) {
        try {
          log('Raw order list data: $data');
          Map<String, dynamic> response = data;
          var orderListData = response['data'] as List;

          if (orderListData.isNotEmpty) {
            orderList?.clear();
            List<SocketOrderModel> orders = orderListData
                .map((orderJson) => SocketOrderModel.fromJson(orderJson))
                .toList();
            orderList = orders;
          } else {
            orderList?.clear();
          }
          notifyListeners();
        } catch (e) {
          log('Error parsing socket data orderList: $e');
        }
      });
      _isOrderListListenerActive = true;
    }
  }

  double dragPosition = 10.w; // Track the drag position
  final double maxDrag = 280.w; // Maximum drag length
  final minDrag = 10.w;
  bool isConfirmed = false; // Track if the action is confirmed

  void onHorizontalDragUpdate(DragUpdateDetails details) {
    dragPosition += details.delta.dx;
    // Prevent sliding left
    if (dragPosition < 0) {
      dragPosition = 10.w;
    }
    // Limit max drag
    if (dragPosition > maxDrag) {
      dragPosition = maxDrag;
    }
    notifyListeners(); // Notify listeners of the change
  }

  void onHorizontalDragEnd(details, context) {
    if (dragPosition >= maxDrag * 0.8) {
      isConfirmed = true;
      dragPosition = maxDrag; // Snap to the end
      debugPrint("Order Placed!");
    } else {
      // Reset position
      dragPosition = 10.w;
      isConfirmed = false;
    }
    notifyListeners();
  }

  bool isLoading = false;
  final ApiService apiService = ApiService();

  //* deliveryStatus API
  Future deliveryStatus({
    required bool isActive,
  }) async {
    isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        "id": sharedPrefsService.getString(SharedPrefsKeys.userId),
        "isActive": isActive,
      };
      final ApiGlobalModel response = await apiService.deliveryStatus(
        body: body,
      );
      log('deliveryStatus Response: $response');
      if (response.success == true) {
        log('Success: deliveryStatus: ${response.message.toString()}');
      } else {
        debugPrint('deliveryStatus Message: ${response.message}');
      }
    } catch (error) {
      log("deliveryStatus Response: $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
      } else {
        //
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void disposeOrderListener() {
    _orderListTimer?.cancel();
    _orderListTimer = null;
    socketService.offEvent(SocketEvents.orderListResponse);
  }
}

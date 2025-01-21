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
          onSocketConnected(); // ! EMIT & LISTEN OrderList
        });
        deliveryStatus(isActive: true); // deliveryStatus apiCall
      } else {
        // * Disconnect from socket server
        socketService.disconnect();
        deliveryStatus(isActive: false); // deliveryStatus apiCall
      }
      notifyListeners();
    }
  }

  List<SocketOrderModel>? orderList;

  // bool isLoading = false;
  void onSocketConnected() {
    // Timer to emit the event every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      // Emit the 'order-list' event
      socketService.emitEvent(SocketEvents.orderList, {});
    });

    /// Listen for the 'order-list-response' event
    socketService.listenToEvent(SocketEvents.orderListResponse, (data) {
      try {
        log('Raw socket data: $data');
        Map<String, dynamic> response = data;
        var orderListData = response['data'] as List;
        if (orderListData.isNotEmpty) {
          // Clear and reinitialize the list to ensure data is fresh
          orderList?.clear();
          List<SocketOrderModel> orders = orderListData
              .map((orderJson) => SocketOrderModel.fromJson(orderJson))
              .toList();
          // Update your UI or state with the parsed data
          orderList = orders;
        } else {
          // If no items, ensure the list is cleared
          orderList?.clear();
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
      // Action confirmed
      isConfirmed = true;
      dragPosition = maxDrag; // Snap to the end
      debugPrint("Order Placed!");
      // Navigator.pushNamed(context, Routes.orderStatus);
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
}

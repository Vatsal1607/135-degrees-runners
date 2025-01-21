import 'dart:async';
import 'dart:developer';
import 'package:degrees_runners/core/constants/keys.dart';
import 'package:degrees_runners/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../models/api_global_model.dart';
import '../../../models/socket_accepted_order_model.dart';
import '../../../services/network/api_service.dart';
import '../../../services/socket/socket_service.dart';

class AcceptedOrderProvider extends ChangeNotifier {
  bool isActive = false;
  // final SocketService socketService = SocketService();

  // AcceptedOrderProvider() {
  //   onSocketConnected(); // ! EMIT & LISTEN acceptedOrderList
  // }

  List<AcceptedOrderModel>? acceptedOrderList;

  // bool isLoading = false;
  void emitAndListenAcceptedOrderList(SocketService socketService) {
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
        var acceptedOrderListData = response['data'] as List;
        if (acceptedOrderListData.isNotEmpty) {
          // Clear and reinitialize the list to ensure data is fresh
          acceptedOrderList?.clear();
          List<AcceptedOrderModel> orders = acceptedOrderListData
              .map((orderJson) => AcceptedOrderModel.fromJson(orderJson))
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

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  //* pick up time API
  Future pickupTime({
    required BuildContext context,
    required String orderId,
    required String type, // 'start' or 'end'
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'orderId': orderId,
        'deliveryBoyId': sharedPrefsService.getString(SharedPrefsKeys.userId),
        'type': type,
      };
      final ApiGlobalModel response = await apiService.pickupTime(
        body: body,
      );
      log('pickupTime Response: $response');
      if (response.success == true) {
        log('Success: pickupTime: ${response.message.toString()}');
      } else {
        debugPrint('User sendotp Message: ${response.message}');
      }
    } catch (error) {
      log("Error during sendotp Response: $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
      } else {
        //
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }
}

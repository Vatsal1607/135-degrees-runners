import 'dart:async';
import 'dart:developer';
import 'package:degrees_runners/core/constants/keys.dart';
import 'package:degrees_runners/services/local/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../models/api_global_model.dart';
import '../../../models/socket_accepted_order_model.dart';
import '../../../models/timer_model.dart';
import '../../../services/network/api_service.dart';
import '../../../services/socket/socket_service.dart';
import 'controllers/timer_provider.dart';

class AcceptedOrderProvider extends ChangeNotifier {
  bool isActive = false;
  // final SocketService socketService = SocketService();

  AcceptedOrderProvider() {
    initializeControllers(acceptedOrderList ?? []);
  }

  @override
  void dispose() {
    timer?.cancel();
    _infinityTimer.cancel();
    log('Accepted Timer disposed');
    super.dispose();
  }

  List<AcceptedOrderModel>? acceptedOrderList;
  final Map<String, TimerProvider> timerMap = {};
  void initializeControllers(List<AcceptedOrderModel?> acceptedOrderList) {
    for (var order in acceptedOrderList) {
      final orderId = order?.orderId;
      if (orderId != null && !timerMap.containsKey(orderId)) {
        timerMap.putIfAbsent(
            orderId, () => TimerProvider()..startInfinityTimer());
      }
    }
  }

  List<TimerModel> pickUpItems = [];
  Timer? timer;
  // bool isLoading = false;
  // void emitAndListenAcceptedOrderList(SocketService socketService) {
  //   // Timer to emit the event every second
  //   timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     // Emit the 'acceptedOrderList' event
  //     socketService.emitEvent(SocketEvents.acceptedOrderList, {
  //       'deliveryBoyId': sharedPrefsService.getString(SharedPrefsKeys.userId),
  //       "socketId": socketService.socket.id,
  //       "role": "4",
  //     });
  //   });

  //   /// Listen for the 'acceptedListResponse' event
  //   socketService.listenToEvent(SocketEvents.acceptedListResponse, (data) {
  //     try {
  //       log('Raw socket acceptedListResponse data: $data');
  //       Map<String, dynamic> response = data;
  //       var acceptedOrderListData = response['data'] as List;
  //       if (acceptedOrderListData.isNotEmpty) {
  //         // Clear and reinitialize the list to ensure data is fresh
  //         acceptedOrderList?.clear();
  //         List<AcceptedOrderModel> acceptedOrders = acceptedOrderListData
  //             .map((orderJson) => AcceptedOrderModel.fromJson(orderJson))
  //             .toList();
  //         // Update your UI or state with the parsed data
  //         acceptedOrderList = acceptedOrders;
  //       } else {
  //         // If no items, ensure the list is cleared
  //         acceptedOrderList?.clear();
  //       }
  //       notifyListeners();
  //     } catch (e) {
  //       log('Error parsing socket data: $e');
  //     }
  //   });
  // }

  void emitAndListenAcceptedOrderList(SocketService socketService) async {
    final deliveryBoyId = sharedPrefsService.getString(SharedPrefsKeys.userId);
    final deviceId = sharedPrefsService
        .getString(SharedPrefsKeys.deviceId); // Fetch unique device ID

    // if (deliveryBoyId.isEmpty) {
    //   log("DeliveryBoyId is missing, cannot proceed.");
    //   return;
    // }

    // Send deliveryBoyId & deviceId once during initialization
    socketService.emitEvent(SocketEvents.acceptedOrderList, {
      'deliveryBoyId': deliveryBoyId,
      'deviceId': deviceId, // Pass unique device identifier
      "socketId": socketService.socket.id,
      "role": "4",
    });

    // Set up periodic listener for updates
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      socketService.emitEvent(SocketEvents.acceptedOrderList, {
        'deliveryBoyId': deliveryBoyId,
        'deviceId': deviceId, // Include deviceId in every request
        "socketId": socketService.socket.id,
        "role": "4",
      });
    });

    //* Listen for the 'acceptedListResponse' event
    socketService.listenToEvent(SocketEvents.acceptedListResponse, (data) {
      try {
        log('Raw socket acceptedListResponse data: $data');

        if (data is Map<String, dynamic>) {
          final acceptedOrderListData = data['data'];

          if (acceptedOrderListData is List) {
            acceptedOrderList = acceptedOrderListData
                .map((orderJson) => AcceptedOrderModel.fromJson(orderJson))
                .toList();
            log("Accepted orders updated: ${acceptedOrderList?.length}");
          } else {
            log("Info: 'data' is empty or not a List.");
            acceptedOrderList?.clear();
          }
        } else {
          log("Warning: Received socket data is not a Map.");
        }
        notifyListeners();
      } catch (e, stack) {
        log('Error parsing socket data acceptedOrderList: $e');
        log('Stack trace: $stack'); // Optional but useful for deep debugging
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
        'orderId': [orderId],
        'deliveryBoyId': [sharedPrefsService.getString(SharedPrefsKeys.userId)],
        'type': type,
      };
      final ApiGlobalModel response = await apiService.pickupTime(
        body: body,
      );
      log('pickupTime Response: $response');
      if (response.success == true) {
        log('Success: pickupTime: ${response.message.toString()}');
      } else {
        debugPrint('pickupTime Message: ${response.message}');
      }
    } catch (error) {
      log("Error during pickupTime Response: $error");
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

  bool isDeliveryTimeLoading = false;
  //* deliveryTime time API
  Future deliveryTime({
    required BuildContext context,
    required String orderId,
    required String type, // 'start' or 'end'
  }) async {
    isDeliveryTimeLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'orderId': orderId,
        'deliveryBoyId': sharedPrefsService.getString(SharedPrefsKeys.userId),
        'type': type,
      };
      final ApiGlobalModel response = await apiService.deliveryTime(
        body: body,
      );
      log('deliveryTime Response: $response');
      if (response.success == true) {
        log('Success: deliveryTime: ${response.message.toString()}');
        Navigator.pop(context);
        return true;
      } else {
        debugPrint('User deliveryTime Message: ${response.message}');
        return false;
      }
    } catch (error) {
      log("Error during deliveryTime Response: $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        return false;
      }
    } finally {
      isDeliveryTimeLoading = false;
      notifyListeners();
    }
  }

  int infinitySeconds = 0;
  late Timer _infinityTimer;

  void startInfinityTimer() {
    infinitySeconds = 0;
    _infinityTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      infinitySeconds++;
      debugPrint('infinitySeconds: $infinitySeconds');
      notifyListeners();
    });
  }

  //* REF:
  // Timer? _timer;
  // int pickUpRemainingSeconds = 0; // Default for the infinite timer
  // bool isCountingDown = false;
  // bool isCountingUp = false;

  // void startTimer({bool isPickupTimeNull = true}) {
  //   if (isPickupTimeNull) {
  //     // Infinite timer logic
  //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //       pickUpRemainingSeconds++;
  //       notifyListeners();
  //     });
  //   } else {
  //     // Countdown timer logic
  //     pickUpRemainingSeconds = 600; // 10 minutes in seconds
  //     isCountingDown = true;

  //     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //       if (isCountingDown) {
  //         if (pickUpRemainingSeconds > 0) {
  //           pickUpRemainingSeconds--;
  //         } else {
  //           isCountingDown = false;
  //           isCountingUp = true;
  //         }
  //       } else if (isCountingUp) {
  //         pickUpRemainingSeconds++;
  //       }
  //       notifyListeners();
  //     });
  //   }
  // }

  bool isLoadingInvoiceGenerate = false;

  //* orderInvoiceGenerate API
  Future orderInvoiceGenerate(
    String orderId,
  ) async {
    isLoadingInvoiceGenerate = true;
    notifyListeners();
    try {
      ApiGlobalModel response = await apiService.orderInvoiceGenerate(
        orderId: orderId,
      );
      log('orderInvoiceGenerate: $response');
      if (response.success == true) {
        //* Success
        log('orderInvoiceGenerate: ${response.message}');
      } else {
        debugPrint('orderInvoiceGenerate Message: ${response.message}');
      }
    } catch (error) {
      log("orderInvoiceGenerate Response: $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
      }
    } finally {
      isLoadingInvoiceGenerate = false;
      notifyListeners();
    }
  }
}

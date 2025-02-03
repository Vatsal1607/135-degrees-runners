import 'dart:developer';
import 'package:degrees_runners/models/order_history_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/keys.dart';
import '../../../models/api_global_model.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';

class HistoryProvider extends ChangeNotifier {
  final ApiService apiService = ApiService();
  bool isLoading = false;
  List<OrderHistory> orderHistoryList = [];
  //* orderHistory API
  Future orderHistory() async {
    isLoading = true;
    notifyListeners();
    try {
      final userId = sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '';
      final OrderHistoryModel response = await apiService.orderHistory(
        userId: userId,
      );
      log('orderHistory Response: $response');
      if (response.success == true) {
        log('Success: orderHistory: ${response.message.toString()}');
        orderHistoryList = response.data?.orderHistory ?? [];
      } else {
        debugPrint('orderHistory Message: ${response.message}');
      }
    } catch (error) {
      log("orderHistory Response: $error");
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
      }
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/constants/keys.dart';
import '../../custom_widgets/custom_snackbar.dart';
import '../../models/api_global_model.dart';
import '../../routes/routes.dart';
import '../../services/local/shared_preferences_service.dart';
import '../../services/network/api_service.dart';

class ProfileProvider extends ChangeNotifier {
  int selectedTileIndex = 0;

  updateTileIndex(int index) {
    selectedTileIndex = index;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  // * Logout API
  Future logout({required BuildContext context}) async {
    _isLoading = true;
    notifyListeners();
    final userId = sharedPrefsService.getString(SharedPrefsKeys.userId);
    final deviceId = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
    try {
      final Map<String, dynamic> body = {
        'userId': userId,
        'deviceId': deviceId,
      };
      final ApiGlobalModel response = await apiService.logout(body: body);
      if (response.success == true) {
        sharedPrefsService.setBool(SharedPrefsKeys.isLoggedIn, false);
        sharedPrefsService.clear();
        // * Navigate Replace all routes navigate to Login page after logout
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.authSelection,
          (Route<dynamic> route) => false,
        );
        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
        return true; // * Indicat success
      } else {
        customSnackBar(
          context: context,
          message: response.message.toString(),
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
        debugPrint('User logout Message: ${response.message}');
        return false; // * Indicat failure
      }
    } catch (error) {
      if (error is DioException) {
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      } else {
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.seaShell,
          textColor: AppColors.primaryColor,
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

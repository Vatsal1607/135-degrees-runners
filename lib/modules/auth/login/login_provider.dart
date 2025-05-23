import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/keys.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../models/api_global_model.dart';
import '../../../models/user_login_model.dart';
import '../../../routes/routes.dart';
import '../../../services/local/auth_token_helper.dart';
import '../../../services/local/shared_preferences_service.dart';
import '../../../services/network/api_service.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController phoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String? mobileErrorText;

  String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile number is required';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Mobile number must contain only numeric values';
    }
    return null;
  }

  @override
  void dispose() {
    // phoneController.clear();
    // phoneController.dispose();
    mobilenumberFocusNode.dispose();
    super.dispose();
  }

  final FocusNode mobilenumberFocusNode = FocusNode();

  onChangePersonalNumber(value) {
    if (value.length != 10) {
      mobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      mobileErrorText = null;
      mobilenumberFocusNode.unfocus();
      notifyListeners();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final ApiService apiService = ApiService();

  //! User login API
  Future<void> userLogin(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      final fcmToken = sharedPrefsService.getString(SharedPrefsKeys.fcmToken);
      final deviceId = sharedPrefsService.getString(SharedPrefsKeys.deviceId);
      final Map<String, dynamic> body = {
        'contact': int.parse('91${phoneController.text}'),
        'role': '4',
        'fcmToken': fcmToken,
        'deviceId': deviceId,
      };
      final LoginModel response = await apiService.userLogin(
        body: body,
      );
      log('User login Response: $response');
      if (response.success == true) {
        log(response.message.toString());
        if (response.data != null) {
          //* Save User Token
          sharedPrefsService.setString(
              SharedPrefsKeys.userToken, response.data!.token!);
          // * Save User id
          sharedPrefsService.setString(
              SharedPrefsKeys.userId, AuthTokenHelper.getUserId().toString());
          // * Save Username
          sharedPrefsService.setString(
              SharedPrefsKeys.username, response.data?.user?.username ?? '');
        }

        //! send otp API call
        await sendOtp(
          context: context,
          mobile: phoneController.text,
          isNavigateToOtpPage: true,
        );
        phoneController.clear();
      } else {
        debugPrint('User login Message: ${response.message}');
      }
    } catch (error) {
      log("Error during User login Response: $error");

      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        // Handle unexpected errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }

  //! send Otp API
  Future sendOtp({
    required BuildContext context,
    bool isNavigateToOtpPage = false,
    required String mobile,
  }) async {
    _isLoading = true;
    notifyListeners();
    try {
      final Map<String, dynamic> body = {
        'contact': int.parse('91$mobile'),
        'role': '4',
      };
      debugPrint('--Request body OTP: $body');
      // Make the API call
      final ApiGlobalModel response = await apiService.sendOtp(
        body: body,
      );
      log('send OTP Response: $response');
      if (response.success == true) {
        log('Success: sendotp: ${response.message.toString()}');
        if (isNavigateToOtpPage) {
          Navigator.pushNamed(context, Routes.otp, arguments: {
            'mobile': phoneController.text,
          });
        }
      } else {
        debugPrint('User sendotp Message: ${response.message}');
      }
    } catch (error) {
      log("Error during sendotp Response: $error");

      if (error is DioException) {
        // Parse API error response
        final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
        customSnackBar(
          context: context,
          message: apiError.message ?? 'An error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      } else {
        // Handle unexpected errors
        customSnackBar(
          context: context,
          message: 'An unexpected error occurred',
          backgroundColor: AppColors.primaryColor,
        );
      }
    } finally {
      // Ensure loading state is reset
      _isLoading = false;
      notifyListeners();
    }
  }
}

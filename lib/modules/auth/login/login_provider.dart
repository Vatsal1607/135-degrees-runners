import 'package:flutter/material.dart';

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

  // @override
  // void dispose() {
  //   // phoneController.clear();
  //   // phoneController.dispose();
  //   super.dispose();
  // }

  onChangePersonalNumber(value) {
    if (value.length != 10) {
      mobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      mobileErrorText = null;
      notifyListeners();
    }
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  // final ApiService apiService = ApiService();

  //! User login API
  // Future<void> userLogin(
  //   BuildContext context,
  //   String accountType,
  // ) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final location = sharedPrefsService.getString(SharedPrefsKeys.location);
  //     final company = sharedPrefsService.getString(SharedPrefsKeys.company);
  //     final Map<String, dynamic> body = {
  //       'contact': int.parse(phoneController.text),
  //       'location': location, // use sharedprefs //selectedLocation
  //       if (accountType == 'business')
  //         'company': company, // business.businessName
  //       'role': accountType == 'business' ? '0' : '1',
  //       'fcmToken': 'xyzwefghhfdsdfffffffffftgfdfcdfds', //Todo add dynamic data
  //       'deviceId': 'jrkjfbsdnanhaifkbsfa', //Todo add dynamic data
  //     };
  //     debugPrint('--Request body: $body');
  //     // Make the API call
  //     final UserLoginModel response = await apiService.userLogin(
  //       body: body,
  //     );
  //     log('User login Response: $response');
  //     if (response.success == true) {
  //       log(response.message.toString());
  //       if (response.data != null) {
  //         //* Save User Token
  //         sharedPrefsService.setString(
  //             SharedPrefsKeys.userToken, response.data!.token!);
  //       }

  //       //! send otp API call
  //       await sendOtp(context, accountType);
  //       phoneController.clear();
  //     } else {
  //       debugPrint('User login Message: ${response.message}');
  //     }
  //   } catch (error) {
  //     log("Error during User login Response: $error");

  //     if (error is DioException) {
  //       // Parse API error response
  //       final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
  //       customSnackBar(
  //         context: context,
  //         message: apiError.message ?? 'An error occurred',
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     } else {
  //       // Handle unexpected errors
  //       customSnackBar(
  //         context: context,
  //         message: 'An unexpected error occurred',
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     }
  //   } finally {
  //     // Ensure loading state is reset
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  //! send Otp API
  // Future<void> sendOtp(
  //   BuildContext context,
  //   String accountType,
  // ) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     final Map<String, dynamic> body = {
  //       'contact': int.parse(phoneController.text),
  //       'role': accountType == 'business' ? '0' : '1',
  //       // 'secondaryContact': '', // optional
  //     };
  //     debugPrint('--Request body OTP: $body');
  //     // Make the API call
  //     final ApiGlobalModel response = await apiService.sendOtp(
  //       body: body,
  //     );
  //     log('send OTP Response: $response');
  //     if (response.success == true) {
  //       log('Success: sendotp: ${response.message.toString()}');
  //       Navigator.pushNamed(context, Routes.otp, arguments: {
  //         'mobile': phoneController.text,
  //       });
  //     } else {
  //       debugPrint('User sendotp Message: ${response.message}');
  //     }
  //   } catch (error) {
  //     log("Error during sendotp Response: $error");

  //     if (error is DioException) {
  //       // Parse API error response
  //       final apiError = ApiGlobalModel.fromJson(error.response?.data ?? {});
  //       customSnackBar(
  //         context: context,
  //         message: apiError.message ?? 'An error occurred',
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     } else {
  //       // Handle unexpected errors
  //       customSnackBar(
  //         context: context,
  //         message: 'An unexpected error occurred',
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     }
  //   } finally {
  //     // Ensure loading state is reset
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }
}

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController personalAddressController = TextEditingController();
  TextEditingController personalMobileController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    personalAddressController.dispose();
    personalMobileController.dispose();
    super.dispose();
  }

  String? selectedBusinessType;
  String? businessMobileErrorText;
  String? personalMobileErrorText;

  onChangeBusinessNumber(value) {
    if (value.length != 10) {
      businessMobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      businessMobileErrorText = null;
      notifyListeners();
    }
  }

  onChangePersonalNumber(value) {
    if (value.length != 10) {
      personalMobileErrorText = 'Please enter exactly 10 digits';
      notifyListeners();
    } else {
      personalMobileErrorText = null;
      notifyListeners();
    }
  }

  final formKey = GlobalKey<FormState>();

  // final ApiService apiService = ApiService();

  // PersonalRegisterModel? _personalRegisterModel;
  bool _isLoading = false;

  // PersonalRegisterModel? get personalRegisterModel => _personalRegisterModel;
  bool get isLoading => _isLoading;

  List<MultipartFile>? multipartImageList;
  List<String> imageFileNames = []; // To store the filenames of selected images

  //* Api method (personal register)
  // Future<void> personalRegister(context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     _personalRegisterModel = await apiService.personalRegister({
  //       'firstName': firstNameController.text,
  //       'lastName': lastNameController.text,
  //       'contact': personalMobileController.text,
  //       'address': personalAddressController.text,
  //     });
  //     debugPrint('Personal Register log: $_personalRegisterModel');
  //     if (_personalRegisterModel?.success == true) {
  //       Navigator.pop(context);
  //       customSnackBar(
  //         context: context,
  //         message: _personalRegisterModel!.message.toString(),
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     }
  //   } catch (e) {
  //     log("personalRegister Error: $e");
  //     if (e is DioException) {
  //       // Extract ApiError from DioError
  //       final apiError = ApiGlobalModel.fromJson(e.response?.data ?? {});
  //       customSnackBar(
  //         context: context,
  //         message: apiError.message.toString(),
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     } else {
  //       // Handle other errors
  //       customSnackBar(
  //         context: context,
  //         message: 'An unexpected error occurred',
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  //* Business Register API Call
  // Future<void> businessRegister(context) async {
  //   _isLoading = true;
  //   notifyListeners();
  //   try {
  //     // Prepare the body for the API request
  //     Map<String, dynamic> body = {
  //       'businessName': businessNameController.text,
  //       'ownerName': businessOwnerController.text,
  //       'ocupant': selectedPropertyStatus,
  //       'images': imageFileNames, // Pass the filenames list as List<String>
  //       'contact': businessMobileController.text,
  //       'address': businessAddressController.text,
  //       'buninessType': selectedBusinessType.toString(),
  //     };

  //     debugPrint('Image filenames being sent: $imageFileNames');

  //     // Call the API
  //     ApiGlobalModel response = await apiService.businessRegister(
  //       body: body,
  //       // images: multipartImageList, // Use the multipart list for file uploads
  //     );

  //     log('Business Register Response: $response');
  //     if (response.success == true) {
  //       clearFields();
  //       Navigator.pop(context);
  //       customSnackBar(
  //         context: context,
  //         message: response.message.toString(),
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     } else {
  //       debugPrint('Response Message: ${response.message}');
  //       debugPrint('Response Success: ${response.success}');
  //     }
  //   } catch (e) {
  //     log("Business Register Error: $e");
  //     if (e is DioException) {
  //       final apiError = ApiGlobalModel.fromJson(e.response?.data ?? {});
  //       customSnackBar(
  //         context: context,
  //         message: apiError.message.toString(),
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     } else {
  //       customSnackBar(
  //         context: context,
  //         message: 'An unexpected error occurred',
  //         backgroundColor: AppColors.primaryColor,
  //       );
  //     }
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  // clearFields() {
  //   businessNameController.clear();
  //   businessOwnerController.clear();
  //   selectedPropertyStatus = null;
  //   imageFileNames = [];
  //   businessMobileController.clear();
  //   businessAddressController.clear();
  //   selectedBusinessType = null;
  // }
}

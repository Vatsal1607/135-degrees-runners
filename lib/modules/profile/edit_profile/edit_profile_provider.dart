import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:degrees_runners/services/network/api_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/keys.dart';
import '../../../core/constants/strings.dart';
import '../../../custom_widgets/custom_snackbar.dart';
import '../../../services/local/shared_preferences_service.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ApiService apiService = ApiService();
  bool isLoading = false;

  //* Get user details
  Future<void> getUserDetails() async {
    isLoading = true;
    notifyListeners();
    try {
      final res = await apiService.getUserDetails(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
      );
      log('getUserDetails: ${res.data}');
      if (res.success == true) {
        final data = res.data;
        userNameController.text = data?.username ?? '';
        addressController.text = data?.address ?? '';
        mobileController.text = data?.contact.toString() ?? '';
        emailController.text = data?.email ?? '';
        profileImage = data?.profileImage;
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error getUserDetails: ${e.toString()}");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  File? selectedImage;

  //* Pick image
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  String? profileImage;

  ImageProvider getProfileImage() {
    if (selectedImage != null) {
      // Show picked image as preview before uploading
      return FileImage(selectedImage!);
    } else if (profileImage?.isNotEmpty == true) {
      // Show image from server after upload
      return CachedNetworkImageProvider(profileImage!);
    } else {
      // Fallback
      return const AssetImage(ImageStrings.personalPic);
    }
  }

  bool isLoadingProfile = false;
  //* EditProfile API
  Future<void> editProfile(
    BuildContext context,
  ) async {
    isLoadingProfile = true;
    notifyListeners();
    try {
      final res = await apiService.editProfile(
        userId: sharedPrefsService.getString(SharedPrefsKeys.userId) ?? '',
        username: userNameController.text.trim(),
        address: addressController.text.trim(),
        contact: mobileController.text.trim(),
        email: emailController.text.trim(),
        profileImage: selectedImage,
      );
      if (res.success == true) {
        selectedImage = null; //* Clear preview after upload
        getUserDetails();
        Navigator.pop(context);
        notifyListeners();
        customSnackBar(context: context, message: '${res.message}');
      } else {
        log('${res.message}');
      }
    } catch (e) {
      debugPrint("Error editProfile: ${e.toString()}");
    } finally {
      isLoadingProfile = false;
      notifyListeners();
    }
  }
}

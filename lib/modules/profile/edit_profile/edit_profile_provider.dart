import 'package:flutter/material.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController emailController = TextEditingController();
}

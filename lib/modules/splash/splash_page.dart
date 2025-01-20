import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/keys.dart';
import '../../core/constants/strings.dart';
import '../../routes/routes.dart';
import '../../services/local/device_info_service.dart';
import '../../services/local/shared_preferences_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final isLoggedIn =
            sharedPrefsService.getBool(SharedPrefsKeys.isLoggedIn);
        log('isLoggedIn: ${isLoggedIn.toString()}');
        if (isLoggedIn != null && isLoggedIn) {
          Navigator.pushReplacementNamed(context, Routes.bottomBar);
        } else {
          Navigator.pushReplacementNamed(context, Routes.authSelection);
        }
        // Navigator.pushReplacementNamed(context, Routes.verifySuccess);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    DeviceInfoService().fetchDeviceId(context);
    return Scaffold(
      // backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Image.asset(
          width: 250.w,
          height: 73.h,
          ImageStrings.runnersLogo,
        ),
      ),
    );
  }
}

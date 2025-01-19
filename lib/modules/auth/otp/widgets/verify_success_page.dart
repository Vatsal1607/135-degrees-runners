import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/constants/strings.dart';
import '../../../../custom_widgets/svg_icons.dart';
import '../../../../routes/routes.dart';

class VerifySuccessPage extends StatefulWidget {
  const VerifySuccessPage({super.key});

  @override
  State<VerifySuccessPage> createState() => _VerifySuccessPageState();
}

class _VerifySuccessPageState extends State<VerifySuccessPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // * Replace all previous routes & Navigate to Bottombar page
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.bottomBar,
          (Route<dynamic> route) => false,
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SvgIcon(
              icon: IconStrings.otpVerified,
              color: AppColors.grey,
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: 270.w,
              height: 120.h,
              child: Text(
                'Verified Successfully!',
                textAlign: TextAlign.center,
                style: GoogleFonts.publicSans(
                  fontSize: 40.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

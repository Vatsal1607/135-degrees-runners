import 'package:degrees_runners/custom_widgets/appbar/appbar_with_back_button.dart';
import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../login/login_provider.dart';
import 'otp_provider.dart';
import 'widgets/otp_fields.dart';

class OtpPage extends StatefulWidget {
  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int _resendSeconds = 30;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  void _startResendTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _resendSeconds > 0) {
        setState(() {
          _resendSeconds--;
        });
        _startResendTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OtpProvider>(context, listen: false);
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ??
            {};
    return Scaffold(
      resizeToAvoidBottomInset: false, //image did't move by the keyboard
      appBar: const AppBarWithBackButton(),
      extendBodyBehindAppBar: true, // show content of body behind appbar
      body: Stack(
        children: [
          Image.asset(
            width: 1.sw,
            height: 1.sh,
            ImageStrings.doodles,
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(
                top: 120.h,
                left: 34.w,
                right: 34.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify",
                    style: GoogleFonts.publicSans(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                        "WE'VE SENT THE OTP TO ",
                        style: GoogleFonts.publicSans(
                            fontSize: 14.sp, color: AppColors.black),
                      ),
                      Text(
                        "+91 ${arguments['mobile']}",
                        style: GoogleFonts.publicSans(
                          fontSize: 14.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18.h),
                  // OTP fields
                  OtpFields(),
                  Consumer<OtpProvider>(
                    builder: (context, _, child) =>
                        provider.remainingSeconds == 0
                            ? GestureDetector(
                                onTap: () {
                                  context
                                      .read<LoginProvider>()
                                      .sendOtp(
                                        mobile: arguments['mobile'],
                                        context: context,
                                      )
                                      .then((isSuccess) {
                                    if (isSuccess != null && isSuccess) {
                                      provider.startTimer();
                                    }
                                  });
                                },
                                child: Text(
                                  'RESEND OTP',
                                  style: GoogleFonts.publicSans(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black,
                                  ),
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: 'resend otp in '.toUpperCase(),
                                  style: GoogleFonts.publicSans(
                                    fontSize: 10.sp,
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '00:${provider.remainingSeconds}',
                                      style: GoogleFonts.publicSans(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.black),
                                    )
                                  ],
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 70.h,
                left: 34.w,
                right: 34.w,
              ),
              child: Consumer<OtpProvider>(
                builder: (context, _, child) => CustomButton(
                  height: 48.h,
                  isLoading: provider.isLoading,
                  onTap: () {
                    if (provider.otpController.text.isNotEmpty) {
                      provider.verifyOtp(
                        context: context,
                        mobile: arguments['mobile'],
                      );
                    }
                  },
                  text: 'verify',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

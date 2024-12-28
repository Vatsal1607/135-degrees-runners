import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/app_colors.dart';
import '../../../core/constants/strings.dart';
import '../../../custom_widgets/custom_button.dart';
import '../../../routes/routes.dart';

class AuthSelectionPage extends StatelessWidget {
  const AuthSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            height: 1.sh,
            width: 1.sw,
            ImageStrings.doodles,
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: 33.w, right: 33.w, top: 130.h),
              child: Column(
                children: [
                  Image.asset(
                    ImageStrings.runnersLogo,
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            bottom: 90.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Hello, Runner!',
                    style: GoogleFonts.publicSans(
                      fontSize: 40.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    'login with your credentials to continue'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                    height: 48.h,
                    onTap: () {
                      Navigator.pushNamed(context, Routes.login);
                    },
                    text: 'login',
                  ),
                  // * Register will do manager
                  // SizedBox(height: 20.h),
                  // CustomButton(
                  //   height: 48.h,
                  //   onTap: () {
                  //     Navigator.pushNamed(context, Routes.register);
                  //   },
                  //   bgColor: AppColors.seaShell,
                  //   text: 'register',
                  //   textColor: AppColors.black,
                  // ),
                  SizedBox(height: 16.h),
                  RichText(
                    text: TextSpan(
                      text: 'BY PROCEEDING, YOU ACCEPT OUR ',
                      style: GoogleFonts.publicSans(
                          fontSize: 10.sp, color: AppColors.black),
                      children: [
                        TextSpan(
                          text: 'T&C ',
                          style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'AND ',
                          style: GoogleFonts.publicSans(
                            fontSize: 10.sp,
                          ),
                        ),
                        TextSpan(
                          text: 'PRIVACY POLICY.',
                          style: GoogleFonts.publicSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

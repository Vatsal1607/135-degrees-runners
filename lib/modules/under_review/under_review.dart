import 'package:degrees_runners/custom_widgets/svg_icons.dart';
import 'package:degrees_runners/modules/under_review/widgets/progress_line_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../core/constants/strings.dart';
import 'widgets/step_icon_widget.dart';

class UnderReviewPage extends StatelessWidget {
  const UnderReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SvgIcon(
                      icon: IconStrings.underReview,
                      color: AppColors.grey,
                    ),
                    SizedBox(height: 20.h),
                    // * Main Text
                    SizedBox(
                      width: 150.w,
                      child: Text(
                        'Under Review!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.publicSans(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // * Progress Bar
          Positioned(
            bottom: 50.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // * Step 1: Completed
                    const StepIconWidget(),
                    SizedBox(
                      width: 100.w,
                      child: const ProgressLineWidget(
                        value: 1,
                      ),
                    ),
                    // * Step 2: In Progress
                    const StepIconWidget(
                      icon: IconStrings.clock,
                      bgColor: AppColors.denimBlue,
                    ),
                    SizedBox(
                      width: 100.w,
                      child: const ProgressLineWidget(
                        value: 0.5,
                      ),
                    ),
                    // * Step 3: Upcoming
                    const StepIconWidget(
                      icon: IconStrings.smile,
                      bgColor: AppColors.grey,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // * Footer Text
                Text(
                  'Your Application Is',
                  style: GoogleFonts.publicSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: AppColors.seaShell,
                  ),
                ),
                Text(
                  'Under Review!',
                  style: GoogleFonts.publicSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.seaShell,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

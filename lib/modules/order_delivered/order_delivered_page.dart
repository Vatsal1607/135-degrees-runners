import 'package:degrees_runners/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_colors.dart';

class OrderDeliveredPage extends StatelessWidget {
  const OrderDeliveredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.green,
      body: Stack(
        children: [
          Positioned(
            bottom: 50.h,
            left: 34.w,
            right: 34.w,
            child: Column(
              children: [
                Text(
                  'Order Delivered!',
                  style: GoogleFonts.publicSans(
                    fontSize: 40.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'at 10:25 aM, 12 January 2025',
                  style: GoogleFonts.publicSans(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                SizedBox(height: 145.h),
                CustomButton(
                  height: 50.h,
                  onTap: () {},
                  text: 'go to orders',
                  isBorder: false,
                  textColor: AppColors.black,
                  bgColor: AppColors.seaShell,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

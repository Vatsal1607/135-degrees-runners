import 'package:degrees_runners/modules/bottom_bar/orders/widgets/bottomsheets/cash_pay_bottom_sheet.dart';
import 'package:degrees_runners/modules/bottom_bar/orders/widgets/bottomsheets/upi_pay_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../core/app_colors.dart';
import '../../../../../core/constants/strings.dart';
import '../../../../../custom_widgets/buttons/custom_button_with_arrow.dart';
import '../../../../../custom_widgets/svg_icons.dart';

void paymentMethodBottomSheeet({
  required BuildContext context,
}) {
  showModalBottomSheet(
    context: context,
    // barrierColor: Colors.transparent,
    backgroundColor: AppColors.seaShell,
    builder: (context) {
      // final authEmpProvider =
      //     Provider.of<AuthorizedEmpProvider>(context, listen: false);
      return Stack(
        clipBehavior: Clip.none, // Allow visible outside the bounds
        children: [
          Positioned(
            child: Container(
              padding: EdgeInsets.only(top: 19.h, left: 32.w, right: 32.w),
              width: 1.sw,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'payment methods'.toUpperCase(),
                    style: GoogleFonts.publicSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomButtonWithArrow(
                    isMargin: false,
                    onTap: () {
                      debugPrint('pay via cash pressed');
                      Navigator.pop(context);
                      cashPayBottomSheeet(context: context);
                    },
                    text: 'pay via cash'.toUpperCase(),
                    prefixWidget: Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: const SvgIcon(
                        icon: IconStrings.cash,
                        color: AppColors.seaShell,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  CustomButtonWithArrow(
                    isMargin: false,
                    onTap: () {
                      debugPrint('pay via upi pressed');
                      Navigator.pop(context);
                      upiPayBottomSheeet(context: context);
                    },
                    text: 'pay via upi'.toUpperCase(),
                    prefixWidget: Container(
                      width: 49.h,
                      height: 19.w,
                      margin: EdgeInsets.only(right: 5.w),
                      child: Image.asset(
                        ImageStrings.upi,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            right: 0,
            left: 0,
            child: IgnorePointer(
              ignoring: true,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  debugPrint('Close pressed');
                },
                child: Container(
                  height: 30.h,
                  width: 30.w,
                  decoration: const BoxDecoration(
                    color: AppColors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const SvgIcon(
                    icon: IconStrings.close,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
